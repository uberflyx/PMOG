function [turb, noGrating] = GenerateTurbulence( Size, gratingNumber, gratingAngle, SR, beamRadiusmm, pixelSizeMicron )
%GENERATETURBULENCE Summary of this function goes here
%   Detailed explanation goes here

%From BV's screen2.m
%SCREEN: produce 2D grid of values for the phase on an SLM to simulate turbulence
% the output is complex valued: the real and imaginary parts two separate 
% to avoid complications with the FFT, the function is calculated on a square grid that fits inside the SLM screen grid
% units are in micron. r0 = Fried parameter [r0 = 0.185*(lambda^2/Cn2/z)^(3/5)]
%  Kolmogorov
% Size = size in pixels (result is square)
% GratingX and Y = number between 0 and 1
% SR = Encoded turbulence strength
% pixelSizeMicron = pixel size [micron]  ---- (typically 8 micron)
%
% Example: imshow(GenerateTurbulence(1080, 0.01,0.01, 0.5, 1, 8))


w0 = (beamRadiusmm/1000) / (pixelSizeMicron / 1000000); %Gaussian beam radius (in pixels)
r0 = w0/(((1/SR)-1)/6.88)^(3/5); % Fried's Parameter

% compute number of points for square area
tal = min(Size,Size);
tal0 = floor(log(tal)/log(2));
Getal = 2^tal0;
Delta = 1/pixelSizeMicron/Getal; % increment size for x and y

% put zero (origin) between samples to avoid singularity
[nx,ny] = meshgrid((1:Getal)-Getal/2-1/2);
Modgrid = real(exp(-1i*pi*(nx+ny)));
rr = (nx.*nx+ny.*ny)*Delta^2;

% Square root of the Kolmogorov spectrum:
qKol = 0.1516*Delta/r0^(5/6)*rr.^(-11/12);

f0 = (randn(Getal)+1i*randn(Getal)).*qKol/sqrt(2);
f1 = fft2(f0).*Modgrid;

% subgrids 
% coordinates and increment sizes (relative to Delta)
ary = [-0.25,-0.25,-0.25,-0.125,-0.125,-0.125,0,0,0,0,0.125,0.125,0.125,0.25,0.25,0.25];
bry = [-0.25,0,0.25,-0.125,0,0.125,-0.25,-0.125,0.125,0.25,-0.125,0,0.125,-0.25,0,0.25];
dary = [0.25,0.25,0.25,0.125,0.125,0.125,0.25,0.125,0.125,0.25,0.125,0.125,0.125,0.25,0.25,0.25];
dbry = [0.25,0.25,0.25,0.125,0.125,0.125,0.25,0.125,0.125,0.25,0.125,0.125,0.125,0.25,0.25,0.25];

ss = (ary.*ary+bry.*bry)*Delta^2;
qsKol = 0.1516*Delta/r0^(5/6)*ss.^(-11/12);
f0 = (randn(1,16)+1i*randn(1,16)).*qsKol/sqrt(2);
fn = f1; % zeros(Getal);
for pp = 1:16
  eks = exp(1i*2*pi*(nx*ary(pp)+ny*bry(pp))/Getal);
  fn = fn + f0(pp)*eks*dary(pp)*dbry(pp);
end

ff = zeros(Size,Size);

ff((Size/2-Getal/2+1):(Size/2+Getal/2),(Size/2-Getal/2+1):(Size/2+Getal/2)) = real(fn);

%%Put a grating:
x=linspace(-1, 1, Size);
y=linspace(-1, 1, Size);
[yy,xx]=meshgrid(y,x);


gratingAngle = pi/180 * gratingAngle;
plane = sin(gratingAngle)*yy + cos(gratingAngle)*xx;
turb = mod(ff + gratingNumber*plane+pi, 2*pi)-pi;
%turb = sin(ff + gratingNumber*plane+pi);

%[X,Y] = meshgrid(-Size/2:Size/2-1,-Size/2:Size/2-1);
%turb = sin(ff + 2*pi*(GratingX*X+GratingY*Y)); %original grating method


a=min(turb(:)); 
b=max(turb(:));

turb=uint8(255*(turb-a)/(b-a));

if nargout == 2
    noGrating = ff;

%turb=sin( gratingNumber*plane + pi);
end

