function [ img ] = ShowImage( img, fs, filename )
%SHOWIMAGE Show the specified image in a window or fullscreen. Can also
%save the image to the specified path.
%   img : A matrix to show / save as image. Must be 0 to 1
%   fs : The screen to show fullscreen on, if 0 then a window is used
%   filename : The path and filename (can be relative). If not specified
%   then the image is not saved. .png is automatically appended.


map=gray(256);

if nargin < 2
    fs = 0;
end

if nargin == 3
    imwrite(img, map, strcat(filename, '.png'));
end

if fs == 0
    figure(1); imshow(img,'Border','tight','InitialMagnification','fit'); truesize(1);
    colormap(map); 
elseif fs > 0
    fullscreen(img,fs);
end

end

