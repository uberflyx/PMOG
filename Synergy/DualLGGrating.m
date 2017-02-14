%generates a 2 lg holograms. All parameters are specified side by side for
%different thangs per hologram.

%[cols rows]
size = [1024 512];

l = [1 -1];
p = [0 0];
complexAmplitude = [false false];

gratingNumber = [10 20];
gratingAngle = [0 0]; %degrees

beamRadius = [2 1]; %mm

fs = 0; %0 is windowed otherwise number is screen number (probably 2) Alt+Tab to close.


%Generate the LG hologram matrix (complex)
matLeft = LGHologram([size(1)/2 size(2)],p(1),l(1),CalculateBeamRadius(size(2),8,beamRadius(1)));
matRight = LGHologram([size(1)/2 size(2)],p(2),l(2),CalculateBeamRadius(size(2),8,beamRadius(2)));
%ComplexFigure(matLeft);

gratingMatLeft = AddGrating(matLeft,gratingNumber(1),gratingAngle(1),complexAmplitude(1));
gratingMatRight = AddGrating(matRight,gratingNumber(2),gratingAngle(2),complexAmplitude(2));

hologram = [gratingMatLeft gratingMatRight];

ShowImage(hologram,fs);