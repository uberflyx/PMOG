function [H] = planeWave(E, xx, yy, k, theta, mode)
% Interferes the field E wirh a plane wave with parameters
% xx, yy : spatial coordinates (cartesian)
% m : frequency of oscilation
% theta : angle of propagation
% mode defines whether the intensity is modulated or not
theta=pi/180*theta;
plane=sin(theta)*xx+cos(theta)*yy;
phase=angle(E);

%Blazed Grating:
H=mod(phase+k*plane+pi, 2*pi)-pi;

%Cosine Grating:
%H=sin(phase+k*plane+pi);

if mode 
    I=E .* conj(E);
    H=I .* H;   
end

a=min(H(:)); b=max(H(:));
H=uint8(255*(H-a)/(b-a));
end

