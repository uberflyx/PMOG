function [ pixels ] = GenerateZernike( sizePixels, nollIndex, scaleMin, scaleMax )
%GENERATEZERNIKE Generates a square 2D matrix representing the zernike polynomial
%specified by the nollIndex. The result is a circule filled with zeros on the outside.
% Example: pixels = GenerateZernike(1080,5,0,1); imshow(pixels);

[n,m] = zernIndex(nollIndex);
div=2/(sizePixels-1);

x = -1:div:1;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
z(idx) = zernfun(n,m,r(idx),theta(idx));

%scale it:
scaleDiff=scaleMax - scaleMin;
pixels = z*(scaleDiff/2)+(scaleDiff/2)+scaleMin;

pixels(isnan(pixels)) = 0 ; %replace NaN with 0
end

