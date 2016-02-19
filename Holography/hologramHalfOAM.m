function [] = hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, pMatrix, lMatrix, screen, useAmplitude, saveImages, hologramOffset)
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
%
%   Example: hologramHalfOAM(200, 0, 0.3, [0 0], [1 -1; 2 -2],2, true, false)

   HalfResolution = [960 1080];
   
  
   
   [A1,E1] = hologramOAM(gratingNumber, gratingAngle,beamWidth, pMatrix(:,1), lMatrix(:,1), -1, useAmplitude, saveImages, HalfResolution);
   [A2,E2] = hologramOAM(gratingNumber, gratingAngle,beamWidth, pMatrix(:,2), lMatrix(:,2), -1, useAmplitude, saveImages, HalfResolution);

    %If an offset is specified then pad the holograms with 0 phase
    if nargin == 9
        %'shift' left matrix
        if hologramOffset(1,1) > 0 
            temp = horzcat(zeros(size(A1,1),hologramOffset(1,1)), A1);
            A1 = temp(:, 1:size(A1,2));
        elseif hologramOffset(1,1) < 0
            temp = horzcat(A1, zeros(size(A1,1),abs(hologramOffset(1,1))));
            A1 = temp(:, (abs(hologramOffset(1,1))+1):size(temp,2));
        end
        if hologramOffset(2,1) > 0
            temp = vertcat(zeros(hologramOffset(2,1), size(A1,2)), A1);
            A1 = temp(1:size(A1,1), :);
        elseif hologramOffset(2,1) < 0
            temp = vertcat(A1, zeros(abs(hologramOffset(2,1)), size(A1,2)));
            A1 = temp((abs(hologramOffset(2,1))+1):size(temp,1), :);
        end
        
        %'shift right matrix
         if hologramOffset(1,2) > 0 
            temp = horzcat(zeros(size(A2,1),hologramOffset(1,2)), A2);
            A2 = temp(:, 1:size(A2,2));
        elseif hologramOffset(1,2) < 0
            temp = horzcat(A2, zeros(size(A2,1),abs(hologramOffset(1,2))));
            A2 = temp(:, (abs(hologramOffset(1,2))+1):size(temp,2));
        end
        if hologramOffset(2,2) > 0
            temp = vertcat(zeros(hologramOffset(2,2), size(A2,2)), A2);
            A2 = temp(1:size(A2,1), :);
        elseif hologramOffset(2,2) < 0
            temp = vertcat(A2, zeros(abs(hologramOffset(2,2)), size(A2,2)));
            A2 = temp((abs(hologramOffset(2,2))+1):size(temp,1), :);
        end
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

