function varargout = hologram(N, k, theta, pMatrix, lMatrix, beamWidth, fs, useAmplitude, saveImages)
% Generates Gaussian beam OAM hologram.
%
% This function is comprehensive and should not really be used by itself.
% Instead, use one of the "helper" function which automatically set
% several of the parameters ofthis function.
%
% N(1), N(2) : number of pixels along each dimension
%
% k :   grating number (typically >100)
% theta: grating orientation (degrees)
%
% pMatrix :     radial Order. Values must be 0 or a matrix the same size as
%               the lMatrix.
% lMatrix :     topological charge. Can be a matrix. [1 2; 5 19] will lay 
%               them in a square.
%
% beamWidth :   radius (mm)
%
% fs:   the screen where to display fullscreen. 
%       0 is a window, 1 is current screen and 2 is probably the SLM. -1
%       does not display.
%       ALT-TAB to exit fullscreen.
%
% useAmplitude :    (optional) whether to use amplitude modulation. If p orders are 
%                   used then this is set to true automatically.
%                   Values: 1 (true) or 0 (false)
%                   Default: 0
%
% saveImages :      (optional) Also save three images (the hologram, OAM
%                   magnitude and OAM phase) for the specified parameters.
%
% Returns: (optional) [oamGrating, oam]
%
% Examples: 
% hologram([1920 1080], 100, 45, 0, 1, .3, 1)
% hologram([1920 1080], 100, 45, 1, [1 2; 3 4], 0.2, 0)

if nargin < 9
   saveImages = false;
end
if nargin < 8
   useAmplitude = 0;
end

grid=size(lMatrix);
N([1 2])=fliplr(N);
points=N./grid;
range=N/min(N);

pMatrix(1:grid(1), 1:grid(2))=pMatrix; 
beamWidth(1:grid(1), 1:grid(2))=beamWidth;
x=linspace(-range(1), range(1), points(1));
y=linspace(-range(2), range(2), points(2));
[yy,xx]=meshgrid(y,x);

if pMatrix ~= 0 
    useAmplitude = 1; % p>0 requires amplitude modulation
end

A(points(1), grid(1), points(2), grid(2))=uint8(0);
for i=1:grid(1)
    for j=1:grid(2)
        E(:,:,i,j)=LGBeam(pMatrix(i,j), lMatrix(i,j), beamWidth(i,j), xx, yy); % OAM
        A(:,i,:,j)=planeWave(E(:,:,i,j), xx, yy, k, theta, useAmplitude); % Grating
    end
end
A=reshape(A, N);
E=reshape(E, N);

%figure(2);imshow(angle(E));

%Deal with function outputs (if any):
nOutputs = nargout;
if nOutputs == 1
    varargout{1} = A;
elseif nOutputs == 2
    varargout{1} = A;
    varargout{2} = E;
end

map=gray(256);
if saveImages == true || saveImages == 1
    lmat = mat2str(lMatrix);
    lmat = strrep(lmat, '[', '');
    lmat = strrep(lmat, ']', '');
    lmat = strrep(lmat, ';', 'x');
    lmat = strrep(lmat, '[', '');
    lmat = strrep(lmat, ' ', '_');
    params = strcat('-l',lmat,'p',mat2str(pMatrix(1,1)),'w',mat2str(beamWidth(1,1)),'k',int2str(k),'theta',int2str(theta),'a',int2str(useAmplitude));
    imwrite(A, map, strcat('holograms\hologram', params, '.png'));
    imwrite(abs(E), strcat('holograms\mag', params, '.png'));
    %figure(2); imagesc(abs(E));
    imwrite(angle(E), strcat('holograms\phase', params, '.png'));
end

if fs == 0
    figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
    colormap(map); 
elseif fs > 0
    fullscreen(A,fs);
end

end