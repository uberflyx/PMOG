function [] = hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, pMatrix, lMatrix, screen, useAmplitude, saveImages, hologramOffset, phaseShift)
%HOLOGRAMHALFOAM Generates an OAM hologram.
%   Calls hologramOAM with the specified parameters except that the
%   resolution is split down the middle so that two holograms can be placed
%   next to eachother. The l and pMatrix variables should have 2 columns
%   otherwise the same hologram will be shown on both sides.
%
%   Parameters: (see hologram or hologramOAM for those not mentioned)
%   hologramOffset: (optional) A matrix specifying the offsets for the left and right
%                   holograms according the calibration data. 
%                   [leftXOffset rightXOffset; leftYOffset rightYOffset]
%   phaseShift:     Adds pi (or pi/2 or whatever) to the generated
%                   holograms. For example: [0 pi] would shift the second hologram by pi.
%
%   Example: hologramHalfOAM(200, 0, 0.3, [0 0], [1 -1; 2 -2],2, true, false)

   HalfResolution = [960 1080];
   
   [A1,E1] = hologramOAM(gratingNumber(1), gratingAngle,beamWidth, pMatrix(:,1), lMatrix(:,1), -1, useAmplitude, saveImages, HalfResolution);
   [A2,E2] = hologramOAM(gratingNumber(2), gratingAngle,beamWidth, pMatrix(:,2), lMatrix(:,2), -1, useAmplitude, saveImages, HalfResolution);

    %If an offset is specified then pad the holograms with 0 phase
    if nargin == 9
        fakeZero = 134; %zero of complex amplitude mod.
        
        %'shift' left matrix
        if hologramOffset(1,1) > 0 
            temp = horzcat(fakeZero*ones(size(A1,1),hologramOffset(1,1)), A1);
            A1 = temp(:, 1:size(A1,2));
        elseif hologramOffset(1,1) < 0
            temp = horzcat(A1, fakeZero*ones(size(A1,1),abs(hologramOffset(1,1))));
            A1 = temp(:, (abs(hologramOffset(1,1))+1):size(temp,2));
        end
        if hologramOffset(2,1) > 0
            temp = vertcat(fakeZero*ones(hologramOffset(2,1), size(A1,2)), A1);
            A1 = temp(1:size(A1,1), :);
        elseif hologramOffset(2,1) < 0
            temp = vertcat(A1, fakeZero*ones(abs(hologramOffset(2,1)), size(A1,2)));
            A1 = temp((abs(hologramOffset(2,1))+1):size(temp,1), :);
        end
        
        %'shift right matrix
         if hologramOffset(1,2) > 0 
            temp = horzcat(fakeZero*ones(size(A2,1),hologramOffset(1,2)), A2);
            A2 = temp(:, 1:size(A2,2));
        elseif hologramOffset(1,2) < 0
            temp = horzcat(A2, fakeZero*ones(size(A2,1),abs(hologramOffset(1,2))));
            A2 = temp(:, (abs(hologramOffset(1,2))+1):size(temp,2));
        end
        if hologramOffset(2,2) > 0
            temp = vertcat(fakeZero*ones(hologramOffset(2,2), size(A2,2)), A2);
            A2 = temp(1:size(A2,1), :);
        elseif hologramOffset(2,2) < 0
            temp = vertcat(A2, fakeZero*ones(abs(hologramOffset(2,2)), size(A2,2)));
            A2 = temp((abs(hologramOffset(2,2))+1):size(temp,1), :);
        end
    end
   
    %Apply a phase shift if required
    if nargin >= 10
        phaseShift = (255/(2*pi)) .* phaseShift;
        A1 = mod(A1 + phaseShift(1), 255);
        A2 = mod(A2 + phaseShift(2), 255);
    end
    
    A = [A1 A2];
    
    if screen == 0
        map=gray(256);
        figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
        colormap(map);
    elseif screen > 0
        fullscreen(A, screen);
    end
end

