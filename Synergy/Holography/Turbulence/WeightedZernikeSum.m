function [weightedSum] = WeightedZernikeSum(size_px, n, m, weights)
% WeightedZernikeSum Returns a (size_px x size_px pixels) phase screen normalised from 0 to 2pi
% of weighted zernike polynomials (specified by n and m).
% Example: 

persistent zScreens

numWeights = length(weights);

%we cache each of the zernike screens and weight them at the end
if isempty(zScreens) || (size(zScreens,1) ~= size_px)
    zScreens = zeros(size_px, size_px, numWeights);
    for i = 1:numWeights
        zScreens(:,:,i) = zScreens(:,:,i) + GenerateZernikeNM(size_px, n(i), m(i), 0, 2*pi);
    end
end

weights = kron(weights, ones(size_px)); %this is now one big 2D matrix
%split it into a 3D matrix
weights = reshape(weights, [size_px, size_px, numWeights]);

weighted = zScreens .* weights;
weightedSum = sum(weighted,3);
weightedSum = mod(weightedSum,2*pi);
end