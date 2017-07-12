%generates a 2 HG holograms. All parameters are specified side by side for
%different thangs per hologram.

%[cols-x rows-y]
size = [1920 1080];

m = [2 0]; %or l
n = [0 1]; % or p
complexAmplitude = [false false];

gratingNumber = [10 10];
gratingAngle = [0 0]; %degrees ([-20 -160] works nicel to separate

beamRadius = [1.5 1.5]; %mm

fs = 3; %0 is windowed otherwise number is screen number (probably 2) Alt+Tab to close.


%Generate the LG hologram matrix (complex)
matA = LGHologram([size(1) size(2)],n(1),m(1),CalculateBeamRadius(size(2),8,beamRadius(1))); %.* LGHologram([size(1)/2 size(2)],n(1),-m(1),CalculateBeamRadius(size(2),8,beamRadius(1)));
matB = HGHologram([size(1) size(2)],n(2),m(2),CalculateBeamRadius(size(2),8,beamRadius(2)));
ComplexFigure([matA matB]);

ComplexFigure([angle(matA) .* angle(matB)]);

gratingMatA = AddGrating(matA,gratingNumber(1),gratingAngle(1),complexAmplitude(1));
gratingMatB = AddGrating(matB,gratingNumber(2),gratingAngle(2),complexAmplitude(2));
%ShowImage([gratingMatA gratingMatB],0);
ComplexFigure([gratingMatA gratingMatB]);

hologram = (gratingMatA + gratingMatB) ./ 2;
ComplexFigure(hologram);

%ShowImage(hologram,fs);