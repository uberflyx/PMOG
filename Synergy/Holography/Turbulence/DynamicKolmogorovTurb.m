function [turbPhaseScreen] = DynamicKolmogorovTurb(size_px, r0, D, numTurbScreens, numInterpolatedScreens, noTipTilt)
%KolmogorovTurb Returns a list of phase screens normalised from 0 to 2pi
%of Kolmogorov turbulence generated with the Zernike-Noll method.
%numTurbScreens dictates the number of main turbulence screens generated
%with numInterpolatedScreens in between each. For example numTurbScreens=10
%with numInterpolatedScreens=9 will result in 100 screens.

% Based on algorithm described in the Burger et al, South African Journal
% of Science 104,129-134 (2008) & Noll, J. Opt. Soc. Am. 66,207-211 (1976).
%Example: ShowImage(KolmogorovTurb(512,0.0001,1)/(2*pi));

%the indeces below are the nollIndex-1 so z1 has noll = 2
persistent zScreens

%tip tilt focus ...
%I = [1.0299 0.5820 0.134 0.111 0.0880 0.0648 0.0587 0.0525 0.0463 0.0401 0.0377 0.0352 0.0328 0.0304 0.0279 0.0267 0.0255 0.0243 0.0232 0.0220];

%alternatively, the same weight is used for both zernikes for |n| and |m|
%for eg. 8,8 and 8,-8, however, a different random variance is still used
[I,n,m] = ZernikeWeightsKolmogorov(D,r0,44); %44 terms
numWeights = length(I);

if (nargin >= 4) && noTipTilt == true
    I(1,1) = 0;
    I(1,2) = 0;
end

%we cache each of the zernike screens and weight them at the end
if isempty(zScreens) || (size(zScreens,1) ~= size_px)
    zScreens = zeros(size_px,size_px, numWeights);
    for i = 1:numWeights
        zScreens(:,:,i) = zScreens(:,:,i) + GenerateZernikeNM(size_px, n(i), m(i), 0, 2*pi);
    end
end

weights = kron(I, ones(size_px)); %this is now one big 2D matrix
%split it into a 3D matrix
weights = reshape(weights, [size_px, size_px, numWeights]);

weighted = zScreens .* weights;
turbPhaseScreen = sum(weighted,3);
turbPhaseScreen = mod(turbPhaseScreen,2*pi);
end