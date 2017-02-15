function [ complexHologram ] = HGHologram( dimensionsXY, mMatrix, nMatrix, beamRadiusPercent )
% Generates Hermite-Gaussian hologram normalised from 0 to 1 (0 to 2pi).
%
% This function is comprehensive and should not really be used by itself.
% Instead, use one of the "helper" function which automatically set
% several of the parameters ofthis function.
%
% dimensionsXY(1), dimensionsXY(2) : number of pixels along each dimension
%
% mMatrix :     x order. Values must be 0 or a matrix the same size as
%               the lMatrix.
% nMatrix :     y order. Can be a matrix. [1 2; 5 19] will lay 
%               them in a square.
%
% beamRadiusPercent :   0.5 will fill the hologram
%
%
% Returns: A complex matrix which contains the LG beam
%
% Example: 
% mat=HGHologram([512 512],[0],[1],0.5); ComplexFigure(mat);
% mat=HGHologram([512 512],[2],[1],CalculateBeamRadius(512,8,2)); ComplexFigure(mat);

grid=size(mMatrix);
N([1 2])=fliplr(dimensionsXY);
points=N./grid;
range=N/min(N);

nMatrix(1:grid(1), 1:grid(2))=nMatrix; 
beamRadiusPercent(1:grid(1), 1:grid(2))=beamRadiusPercent;
x=linspace(-range(1), range(1), points(1));
y=linspace(-range(2), range(2), points(2));
[yy,xx]=meshgrid(y,x);

%E(points(1), grid(1), points(2), grid(2)) = 0;
E = zeros(N);
for i=1:grid(1)
    for j=1:grid(2)
        E(:,:,i,j)=HGBeam(nMatrix(i,j), mMatrix(i,j), beamRadiusPercent(i,j), xx, yy); % OAM
        %A(:,i,:,j)=grating(E(:,:,i,j), xx, yy, gratingNumber,
        %gratingAngleDegrees, useAmplitude); % no grating in this function
    end
end
%A=reshape(A, N);
E=reshape(E, N);

%normalise from 0 to 1
complexHologram = E/max(max(E));

end

