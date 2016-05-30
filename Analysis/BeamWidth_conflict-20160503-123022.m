function [ inve2 ] = BeamWidth( img, rowIndex, pixelWidthum )
%BEAMWIDTH Fits a guassiam to the specified img and returns the beam width.
%   Returs 1/e^2 and FWHM values

rowVector = double(img(rowIndex, :)) ./ 255
x = [1:size(img,2)] .* pixelWidthum;

f = fit(x',rowVector','gauss1');

plot(f,x,rowVector)

inve2 = 0.135

end

