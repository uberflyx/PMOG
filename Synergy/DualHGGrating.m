%generates a 2 HG holograms. All parameters are specified side by side for
%different thangs per hologram.

%[cols rows]
size = [1024 512];

m = [0 2];
n = [0 2];
complexAmplitude = [false true];

gratingNumber = [10 20];
gratingAngle = [0 0]; %degrees

beamRadius = [0.5 0.5]; %mm

fs = 0; %0 is windowed otherwise number is screen number (probably 2) Alt+Tab to close.


%Generate the LG hologram matrix (complex)
matLeft = HGHologram([size(1)/2 size(2)],n(1),m(1),CalculateBeamRadius(size(2),8,beamRadius(1)));
matRight = HGHologram([size(1)/2 size(2)],n(2),m(2),CalculateBeamRadius(size(2),8,beamRadius(2)));
ComplexFigure([matLeft matRight]);

gratingMatLeft = AddGrating(matLeft,gratingNumber(1),gratingAngle(1),complexAmplitude(1));
gratingMatRight = AddGrating(matRight,gratingNumber(2),gratingAngle(2),complexAmplitude(2));

hologram = [gratingMatLeft gratingMatRight];

%ShowImage(hologram,fs);