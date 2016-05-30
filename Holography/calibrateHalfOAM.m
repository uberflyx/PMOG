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
hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false);
pause(0.3);

%display the selection dialog
[center] = findOAMCenter(vid, 1);
fprintf('Center selected at: %s\n', mat2str(center));

%% shift the left grating left and right to find maximum at center pixel

offsetLeft = [0;0];
offsetRight = [0;0];
%offset = horzcat(offsetLeft, offsetRight);

%get a baseline value
hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
pause(0.3);
img = getsnapshot(vid);
baselineGaussian = double(img(center(2), center(1)));
fprintf('Initial center intensity: %s\n', num2str(baselineGaussian));

figure(2); imshow(img);

fprintf('Starting gaussian optimisation...\n');

% Future Algorithm:
% A hill ascent or descent. At each step of the algorithm, all neighboring
% points are scanned for the next best intensity. Once the best is found,
% the current is set to that offset and the algorithm repeats. This will
% only find a local maximum or minimum, so alignment initially has to be
% decent.
%
% Current Algorithm:
% The parameters are swept and the best value is recorded. First, the
% grating offsets are tested in x. Once the best value is found, the
% grating is rotated 90 degrees and the y offset is found. This is first
% done for the left hologram and then the right


%optimise angle
bestAngle = 0;
currIntensity = 0;
bestIntensity = 0;

for ang = -2:0.1:2
    hologramHalfOAM(gratingNumber, ang, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
    pause(0.3);
    img = getsnapshot(vid);
    currIntensity = double(img(center(2), center(1)));
    
    if (currIntensity > bestIntensity)
        bestIntensity = currIntensity;
        bestAngle = ang;
    end
end

fprintf('Max angular intensity: %s at %s\n', num2str(bestIntensity), num2str(bestAngle));

bestOffset = [0;0];

for x = -10:1:10
    offsetLeft = [x;0];
    hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
    pause(0.3);
    img = getsnapshot(vid);
    currIntensity = double(img(center(2), center(1)));
    
    if (currIntensity > bestIntensity)
        bestIntensity = currIntensity;
        bestOffset = offsetLeft;
    end
end

fprintf('Max x intensity: %s at %s\n', num2str(bestIntensity), mat2str(bestOffset));
offsetLeft = bestOffset;
bestIntensity = 0;

for y = -10:1:10
    offsetLeft(2,1) = y;
    hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
    pause(0.3);
    img = getsnapshot(vid);
    currIntensity = double(img(center(2), center(1)));
    
    if (currIntensity > bestIntensity)
        bestIntensity = currIntensity;
        bestOffset = offsetLeft;
    end
end

fprintf('Max y intensity: %s at %s\n', num2str(bestIntensity), mat2str(bestOffset));
offsetLeft = bestOffset;

%Right hologram
bestOffset = [0;0];

for x = -10:1:10
    offsetRight = [x;0];
    hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
    pause(0.3);
    img = getsnapshot(vid);
    currIntensity = double(img(center(2), center(1)));
    
    if (currIntensity > bestIntensity)
        bestIntensity = currIntensity;
        bestOffset = offsetRight;
    end
end

fprintf('Max x intensity: %s at %s\n', num2str(bestIntensity), mat2str(bestOffset));
offsetRight = bestOffset;
bestIntensity = 0;

for y = -10:1:10
    offsetRight(2,1) = y;
    hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
    pause(0.3);
    img = getsnapshot(vid);
    currIntensity = double(img(center(2), center(1)));
    
    if (currIntensity > bestIntensity)
        bestIntensity = currIntensity;
        bestOffset = offsetRight;
    end
end

fprintf('Max y intensity: %s at %s\n', num2str(bestIntensity), mat2str(bestOffset));
offsetRight = bestOffset;


%get a final value
hologramHalfOAM(gratingNumber, 0, beamWidth, [0 0], [1 -1], screen, useAmplitude, false, horzcat(offsetLeft, offsetRight));
pause(0.3);
img = getsnapshot(vid);
currIntensity = double(img(center(2), center(1)));
fprintf('Final center intensity: %s\n', num2str(currIntensity));

figure(3); imshow(img);

offset = horzcat(offsetLeft, offsetRight);

end

