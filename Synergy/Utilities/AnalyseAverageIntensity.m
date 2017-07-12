function [ intensity ] = AnalyseAverageIntensity( path, x, y, radius )
%ANALYSEAVERAGEINTENSITY Returns the average intensity (pixel value) of all
%of the images in the specified folder at the specified pixel. Optionally,
%a radius can be specified which is the number of pixels around the
%coordinateXY to average. This simualtes a photodiode.
%
% Example: AnalyseAverageIntensity( 'D:\Pictures\*.png', 100, 100, 0 )

total = 0;
region = [];

if nargin < 4
    radius = 0; %just center pixel
end

%Get files
imagefiles = dir(path);
count = length(imagefiles);
if (count <= 0)
    error('No images in path!');
end

%set up measurement region (radius 0 is just the pixel)
tempImage = imread(imagefiles(1).name);
[xx, yy] = meshgrid(1:size(tempImage,2), 1: size(tempImage,1));
xx2 = xx - x;
yy2 = yy - y;
region = xx2.^2 + yy2.^2 <= radius.^2;


for f = 1:count
    currentFilename = imagefiles(f).name;
    [currentImage,map] = imread(currentFilename);
    
    %undo the map (what a rash). This assumes jet, but may work for others.
    %[~,idx] = sortrows(rgb2hsv(jet(256)), -1);
    %C = gray(256);
    %C = C(idx,:);
    
    %imshow(currentImage,'Colormap',C)
    currentImage = double(currentImage) .* region; %only leave area of interest
    
    %process each image at a time to conserve RAM
    total = total + sum(sum(currentImage));
end

intensity = total / count;

end

