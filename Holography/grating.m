function [H] = grating(E, xx, yy, k, theta, mode, wavelength, type)
% Interferes the field E wirh a plane wave with parameters
% xx, yy : spatial coordinates (cartesian)
% k : number of gratings.
% theta : angle of propagation
% mode defines whether the intensity is modulated or not
% wavelength : lambda in meters (default is 633e-9)
% grating : 'sin' or 'blazed'

%% Magic Numbers: (Modify these defaults)
SLMPixelPitch = 8e-6; % m
DefaultWavelength = 633e-9; % m


%% Where the Magic Happens: (Don't modify below here)
if nargin < 8
    type = 'blazed';
end
if nargin < 7
    wavelength = DefaultWavelength;
end

theta=pi/180*theta;
plane=sin(theta)*xx+cos(theta)*yy;
phase=angle(E);



if strcmp(type, 'sin') == true
    %Sin Grating
    H=sin(phase+k*plane+pi);
else %strcmp(grating, 'blazed') == true
    % Blazed Grating
    
    % See: https://en.wikipedia.org/wiki/Blazed_grating
    
    H=mod(phase+k*plane+pi, 2*pi)-pi;
end

if mode 
    I=E .* conj(E);
    H=I .* H;   
end

a=min(H(:)); 
b=max(H(:));

H=uint8(255*(H-a)/(b-a));
end

