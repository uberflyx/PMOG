function [center] = AnimateTurbulence( DimensionsXY, gratingNumber, gratingAngle, SR, beamWidthmm, pixelSizeMicron, fs, frames, delay, filename, vid, SLM2PhaseShift, centerExisting )
%ANIMATETURBULENCE Animates through random turbulence screens with the
%specified parameters. If vid is specified then an image is captured and
%saved after each iteration.
%   See GenerateTurbulence for parameters
%   fs : The screen to display on
%   frames : the number of turbulence frames to animate through
%   delay : the pause (in seconds) between each frame
%   vid : the video variable from the Image Capture App
%
%   filename : the path + filename of the images to save. A number and the
%   type (turbulence or camera capture) as well as .png is appended to each image 
%   automatically.
%
%   Example: AnimateTurbulence( [1920 1080], 200, 90, 0.5, 1, 8, 0, 10, 0.5)

% Print parameters to a txt file for future reference
if (nargin >= 10)
    fileID = fopen(strcat(filename, '-parameters.txt'), 'w'); 
    
    fprintf(fileID, strcat(filename, '\n'));
    fprintf(fileID,strcat('DimensionsXY: ', mat2str(DimensionsXY), '\n'));
    fprintf(fileID,'gratingNumber: %f \n', gratingNumber);
    fprintf(fileID,'gratingAngle: %f \n', gratingAngle);
    fprintf(fileID,'SR: %f \n', SR);
    fprintf(fileID,'beamWidthmm: %f \n', beamWidthmm);
    fprintf(fileID,'pixelSizeMicron: %f \n', pixelSizeMicron);
    fprintf(fileID,'delay: %f \n', delay);
    fprintf(fileID,'frames: %i \n', frames);
    
    fclose(fileID);
end

if (nargin < 12)
    SLM2PhaseShift = 0;
else
    SLM2PhaseShift = SLM2PhaseShift * (255/(2*pi));
end

ShowImage(CroppedTurbulence(GenerateTurbulence(DimensionsXY(2), gratingNumber, gratingAngle, 1, beamWidthmm, pixelSizeMicron), DimensionsXY, SLM2PhaseShift), fs);
pause(0.3);
if nargin >= 13
    center = centerExisting;
else
    autoGain(vid.Source,vid,255,[0 5], [-11000 23990]);
    [center] = findOAMCenter(vid, 1);
end

fprintf('Center selected at: %s\n', mat2str(center));
img = getsnapshot(vid);

total = 0;
average = 0;
calibration = double(img(center(2), center(1)));

for i = 1 : frames

    if (nargin >= 10)
        filen = strcat(filename, '-turb-', int2str(i));
        ShowImage(CroppedTurbulence(GenerateTurbulence(DimensionsXY(2), gratingNumber, gratingAngle, SR, beamWidthmm, pixelSizeMicron), DimensionsXY, SLM2PhaseShift), fs);
        pause(delay);
    
        if (nargin >= 11) %Take a photo
            img = getsnapshot(vid);
            imwrite(img, strcat(filename, '-capture-', int2str(i), '.png'));    
            
            pause(delay);
            
            %add the center point to the results matrix, for averaging later        
            average = average + double(img(center(2), center(1)));
            total = total + 1;
        end
        
    else
        ShowImage(CroppedTurbulence(GenerateTurbulence(DimensionsXY(2), gratingNumber, gratingAngle, SR, beamWidthmm, pixelSizeMicron), DimensionsXY, SLM2PhaseShift), fs);
        pause(delay);
    end   
end

average = average / total;
fprintf('Average at center is: %s / %s\n', num2str(average), num2str(calibration));

end

