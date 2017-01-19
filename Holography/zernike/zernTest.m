pixels = 1080;
nollIndex = 5;

[n,m] = zernIndex(nollIndex);
div=2/(pixels-1);
x = -1:div:1;
[X,Y] = meshgrid(x,x);
[theta,r] = cart2pol(X,Y);
idx = r<=1;
z = nan(size(X));
z(idx) = zernfun(n,m,r(idx),theta(idx));
z = z*127.5+127.5;
figure
pcolor(x,x,z), shading flat
colormap gray
axis square, colorbar
title(strcat('Zernike function Z_n^m(r,\theta), n=',n,' m=',m))
