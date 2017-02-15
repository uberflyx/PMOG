function [ complexHologram ] = BPHologram( dimensionsXY, lMatrix, mMatrix, beamRadiusPercent )
% Generates Bessel-Poincare hologram normalised from 0 to 1 (0 to 2pi).
%
% This function is comprehensive and should not really be used by itself.
% Instead, use one of the "helper" function which automatically set
% several of the parameters ofthis function.
%
% dimensionsXY(1), dimensionsXY(2) : number of pixels along each dimension
%
% lMatrix :     Radial order. Values must be 0 or a matrix the same size as
%               the lMatrix.
% mMatrix :     Topological charge. Can be a matrix. [1 2; 5 19] will lay 
%               them in a square.
%
% beamRadiusPercent :   0.5 will fill the hologram
%
%
% Returns: A complex matrix which contains the LG beam
%
% Example: 
% mat=BPHologram([512 512],[5],[0],0.5); ComplexFigure(mat);
% mat=BPHologram([512 512],[3],[1],CalculateBeamRadius(512,8,2)); ComplexFigure(mat);

grid=size(lMatrix);
N([1 2])=fliplr(dimensionsXY);
points=N./grid;
range=N/min(N);

mMatrix(1:grid(1), 1:grid(2))=mMatrix; 
beamRadiusPercent(1:grid(1), 1:grid(2))=beamRadiusPercent;
x=linspace(-range(1), range(1), points(1));
y=linspace(-range(2), range(2), points(2));
[yy,xx]=meshgrid(y,x);

%E(points(1), grid(1), points(2), grid(2)) = 0;
E = zeros(N);
for i=1:grid(1)
    for j=1:grid(2)
        E(:,:,i,j)=BPBeam(mMatrix(i,j), lMatrix(i,j), beamRadiusPercent(i,j), xx, yy); % OAM
        %A(:,i,:,j)=grating(E(:,:,i,j), xx, yy, gratingNumber,
        %gratingAngleDegrees, useAmplitude); % no grating in this function
    end
end
%A=reshape(A, N);
E=reshape(E, N);

%normalise from 0 to 1
complexHologram = E/max(max(E));

end

