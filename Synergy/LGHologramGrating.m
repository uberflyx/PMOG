%generates a simple lg hologram with a grating

%[cols rows]
size = [500 500];

l = [2];
p = [2];
complexAmplitude = true;

gratingNumber = 100;
gratingAngle = 0; %degrees

beamRadius = 1.5; %mm


%Generate the LG hologram matrix (complex)
mat = HGHologram(size,p,l,CalculateBeamRadius(size(2),8,beamRadius));
ComplexFigure(mat);


gratingMat = AddGrating(mat,gratingNumber,gratingAngle,complexAmplitude);

%ShowImage(gratingMat);