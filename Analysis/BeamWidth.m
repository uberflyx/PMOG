function [ inve2 ] = BeamWidth( img, rowIndex, pixelWidthum )
%BEAMWIDTH Fits a guassiam to the specified img and returns the beam width in mm.
%   Returs 1/e^2 and FWHM values
%   https://en.wikipedia.org/wiki/Beam_diameter#1.2Fe2_width

rowVector = double(img(rowIndex, :));
rowVector = rowVector ./ max(rowVector);%normalise camera image
x = [1:size(img,2)];

f = fit(x',rowVector','gauss1');

plot(f,x,rowVector)

for i = 1:size(x,2)
    y(1,i) = f(i);
end

tmp = abs(y - 0.135);
[idx idx] = min(tmp);

%closest value is: y(idx)
inve2 = (abs(idx - f.b1)) * (pixelWidthum / 1000);

end

