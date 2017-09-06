%generates a simple lg hologram and decomposes it again

%[cols rows]
size = [512 512];

l = [1];
p = [0];
complexAmplitude = false;

beamRadius = 1.5; %mm

gaussBeam = LGHologram(size,0,0,CalculateBeamRadius(size(2),8, beamRadius));
ComplexFigure(gaussBeam);

%Generate the LG hologram matrix (complex)
LGscreen = angle(LGHologram(size,p,l,CalculateBeamRadius(size(2),8, beamRadius))); %-pi to pi

ComplexFigure(LGscreen);

%decomposition hologram
decomp = LGHologram(size,p,l,CalculateBeamRadius(size(2),8, beamRadius));