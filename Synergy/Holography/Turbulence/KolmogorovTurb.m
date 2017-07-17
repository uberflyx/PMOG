function [turbPhaseScreen] = KolmogorovTurb(size_px, r0, D, noTipTilt)
%KolmogorovTurb Returns a phase screen normalised from 0 to 2pi
%of Kolmogorov turbulence generated with the Zernike-Noll method.
%Paramters:

%the indeces below are the nollIndex-1 so z1 has noll = 2
persistent zScreens

%tip tilt focus ...
I = [1.0299 0.5820 0.134 0.111 0.0880 0.0648 0.0587 0.0525 0.0463 0.0401 0.0377 0.0352 0.0328 0.0304 0.0279 0.0267 0.0255 0.0243 0.0232 0.0220];

if (nargin < 4) || noTipTilt == true
    I(1,1) = 0;
    I(1,2) = 0;
end

%we cache each of the zernike screens and weight them at the end
if isempty(zScreens) || (size(zScreens,1) ~= size_px)
    zScreens = zeros(size_px,size_px,20);
    for i = 1:20
        zScreens(:,:,i) = zScreens(:,:,i) + GenerateZernike(size_px,i+1,0,2*pi);
    end
end

sigmas = sqrt(I .* (D/r0)^(5/3));
%weights = zeros(size_px, size_px, 20);
w = sigmas .* randn(1,size(sigmas,1));

weights = kron(w, ones(size_px)); %this is now one big 2D matrix
%split it into a 3D matrix
weights = reshape(weights, [size_px, 1, 20]);

weighted = zScreens * weights;
turbPhaseScreen = sum(weighted,3);
%turbPhaseScreen = mod(turbPhaseScreen,2*pi);
%turbPhaseScreen = turbPhaseScreen / (2*pi);
end