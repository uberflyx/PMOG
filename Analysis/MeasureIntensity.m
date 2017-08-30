function [ ave, min, max, stddev ] = MeasureIntensity( path, filenamePrefix, fileExtension, centerPixel, outputGifFilename, makeGif )
%MEASUREINTENSITY Check the specified center pixel of all the files that
%match filenamePrefix.
%
% path : The absolute or relative path the the directory with the files
%           ending with /
% filenamePrefix : The first few characters of the filename to search for
% fileExtension : 'png' or 'jpg' for example
% centerPixel : The pixel to analyse

fileList = dir(strcat(path, filenamePrefix, '*.', fileExtension));

centerValue = 0;
aveTotal = 0;
aveCount = 0;
min = 999999;
max = 0;
stddev = 0;

makeGif = false;

fprintf('Measuring %s files...\n', int2str(size(fileList,1)));



for fileIdx = 1:size(fileList,1)
    filename = strcat(path, fileList(fileIdx).name);
    img = imread(filename);
    
    %if (nargin >= 6) 
        if (makeGif == true)
        figure(1);
        %Make an animated gif :)
        imshow(img);
        hold on;
        plot(centerPixel(1), centerPixel(2), 'go');
        frame = getframe(1);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
        if fileIdx == 1;
            imwrite(imind,cm,outputGifFilename,'gif', 'Loopcount',inf,'DelayTime',0.1);
        else
            imwrite(imind,cm,outputGifFilename,'gif','WriteMode','append','DelayTime',0.1);
        end
        end
    %end
    
    centerValue(fileIdx) = double(img(centerPixel(2), centerPixel(1)));
    %centerValue = centerValue - 3; %dark noise
    
    aveTotal = aveTotal + centerValue(fileIdx);
    aveCount = aveCount + 1;
    
    if (centerValue(fileIdx) < min)
        min = centerValue;
    end
    
    if (centerValue(fileIdx) > max)
        max = centerValue;
    end
end

ave = aveTotal / aveCount;

%stddev:
%stddev = sqrt(1/aveCount * sum((centerValue - ave).^2));
stddev = std(centerValue);

end

