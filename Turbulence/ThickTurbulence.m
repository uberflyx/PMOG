function [ ] = ThickTurbulence( Cn, D, L )
%THICKTURBULENCE    Generates two turbulence screens which represent an
%                   equivalent thick turbulence of many thing screen 
%                   turbulence plates over a >1 k m distance.
%   Based on the paper:  
%   Rodenburg, B. et al. (2014). Simulating thick atmospheric turbulence in the lab with application to orbital angular momentum communication. New Journal of Physics, 16(3), 033020. http://doi.org/10.1088/1367-2630/16/3/033020
%
%   Cn  :   ...
%   D   :   Diameter of aperture of beam
%   L   :   Length of link

% Constants:
k = 1;


% Step One:
r0 = ((2.91/6.88) * (k^2) * (Cn^2) * L)^(-3/5); %Eq. 4
sigmaXSquared = ((0.563*6)/11) * (k^(7/6)) * (Cn^2) * (L^11/6); %Eq. 5

sigmaPSquared = 1; %Eq. 6 FML...

% Hard-code for testing:
r0 = 24.4; %mm
sigmaXSquared = 0.197;
sigmaPSquared = 7.04e-3;
pBP = 500; %m^-2 (MC: Where does this come from??)

Dr0 = D / r0;

% Step Two:
% Find the values for the position and r0 for the two screens that will
% give the same values of r0, sigmaX, sigmaP and pBP of the thick path...

% 

end

