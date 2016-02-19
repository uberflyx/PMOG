function [ offset ] = calibrateHalfOAM( gratingNumber, gratingAngle, beamWidth, useAmplitude, screen, vid )
%CALIBRATEHALFOAM Calibrates the position of the forked hologram and return
%the offet pizes for each half hologram as [xOffset yOffset].
%   Input the usual parameters as well as some "sweep" parameters which the
%   algorithm will use to try find a sweet spot. The algorithm first
%   adjusts the first hologram while maintaining a simple grating on the
%   second and then adjusts the second. The first phase of adjustment
%   attempts to discore a maximum light yield for a guassian beam and then
%   a LG with l=1 and -1 to get minimum light at the specified pixel.
%
%   Returns: offset := [leftXOffset rightXOffset; leftYOffset rightYOffset]

%% First we need to get the user to select an optimal center pixel
%Set up
hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [0 0], [0 1], screen, useAmplitude, false);
pause(0.2);

%display the selection dialog
[center] = findOAMCenter(vid, 1);
fprintf('Center selected at: %s\n', mat2str(center));

%% shift the left grating left and right to find maximum at center pixel

hologramHalfOAM(gratingNumber, gratingAngle, beamWidth, [0 0], [0 0], screen, useAmplitude, false);
pause(0.2);

end

