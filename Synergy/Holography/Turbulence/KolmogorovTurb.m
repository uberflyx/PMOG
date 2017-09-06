function [turbPhaseScreen] = KolmogorovTurb(size_px, r0, D, noTipTilt)
%KolmogorovTurb Returns a phase screen normalised from 0 to 2pi
%of Kolmogorov turbulence generated with the Zernike-Noll method.
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

if (nargin >= 4) && noTipTilt == true
    I(1,1) = 0;
    I(1,2) = 0;
end

turbPhaseScreen = WeightedZernikeSum(size_px,n,m,I);

end