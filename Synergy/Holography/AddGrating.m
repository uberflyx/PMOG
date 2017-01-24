function [ phaseHologram ] = AddGrating( inputHologram, gratingNumber, gratingAngle, complexAmplitude, gratingType )
%ADDGRATING Adds a grating to the provided hologram and outputs it as a
%phase-only matrix of doubles normalised to +-1 (origianlly +-pi).
%   gratingType is 'sin' or 'blazed' (defaults to blazed)
%   Example: gmat = AddGrating(mat,50,0,false);

if nargin < 5
    gratingType = 'blazed';
end

%create meshgrid
x=linspace(-1, 1, size(inputHologram,1));
y=linspace(-1, 1, size(inputHologram,2));
[yy,xx]=meshgrid(y,x);

theta=pi/180*gratingAngle;
plane=sin(theta)*xx+cos(theta)*yy;
phase=angle(inputHologram);

if strcmp(gratingType, 'sin') == true
    %Sin Grating
    phaseHologram=sin(phase+gratingNumber*plane+pi);
else %strcmp(grating, 'blazed') == true
    % Blazed Grating
    % See: https://en.wikipedia.org/wiki/Blazed_grating
    phaseHologram=mod(phase+gratingNumber*plane+pi, 2*pi)-pi;
end

if (complexAmplitude)
    intensity = abs(inputHologram);
    phaseHologram = phaseHologram .* intensity;
end

%renormalise to +-1
phaseHologram=(phaseHologram-pi)/(-pi-pi);

end

