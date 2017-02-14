%generates a simple lg hologram with a grating

%[cols rows]
size = [1920 1080];

l = [1];
p = [0];
complexAmplitude = true;

gratingNumber = 100;
gratingAngle = 0; %degrees

beamRadius = 1; %mm


%Generate the LG hologram matrix (complex)
mat = LGHologram(size,p,l,CalculateBeamRadius(size(2),8,beamRadius));
%ComplexFigure(mat);

gratingMat = AddGrating(mat,gratingNumber,gratingAngle,complexAmplitude);

ShowImage(gratingMat);