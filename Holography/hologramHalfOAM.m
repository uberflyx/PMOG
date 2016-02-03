function [] = hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, pMatrix, lMatrix, screen, useAmplitude, saveImages)
%HOLOGRAMHALFOAM Generates an OAM hologram.
%   Calls hologramOAM with the specified parameters except that the
%   resolution is split down the middle so that two holograms can be placed
%   next to eachother. The l and pMatrix variables should have 2 columns
%   otherwise the same hologram will be shown on both sides.
%
%   Example: hologramHalfOAM(200, 0, 0.3, [0 0], [1 -1; 2 -2],2, true, false)

   HalfResolution = [960 1080];
   
   [A1,E1] = hologramOAM(gratingNumber, gratingAngle,beamWidth, pMatrix(:,1), lMatrix(:,1), -1, useAmplitude, saveImages, HalfResolution);
   [A2,E2] = hologramOAM(gratingNumber, gratingAngle,beamWidth, pMatrix(:,2), lMatrix(:,2), -1, useAmplitude, saveImages, HalfResolution);

    A = [A1 A2];
    
    if screen == 0
        map=gray(256);
        figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
        colormap(map);
    elseif screen > 0
        fullscreen(A, screen);
    end
end

