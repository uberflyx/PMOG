function [] = hologram(N, k, theta, p, l, w, fs)
% Generates Gaussian beam hologram
% N(1), N(2) : number of pixels along each dimension
% m : number of grids
% k : grid orientation
% p : radial Order
% l : topological charge
% w : radius
% fs: the screen where to display fullscreen. 0 is a window. ALT-TAB to
% exit fullscreen.
% Example: hologram([1920 1080], 100, 45, 0, 1, 10)
grid=size(l);
N([1 2])=fliplr(N);
points=N./grid;
range=N/min(N);

p(1:grid(1), 1:grid(2))=p; 
w(1:grid(1), 1:grid(2))=w;
x=linspace(-range(1), range(1), points(1));
y=linspace(-range(2), range(2), points(2));
[yy,xx]=meshgrid(y,x);

A(points(1), grid(1), points(2), grid(2))=uint8(0);
for i=1:grid(1)
    for j=1:grid(2)
        E=LGBeam(p(i,j), l(i,j), w(i,j), xx, yy);
        A(:,i,:,j)=planeWave(E, xx, yy, k, theta, 0);
    end
end
A=reshape(A, N);

if fs == 0
    figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
    map=gray(256); colormap(map); 
    %imwrite(Hol, map, 'Test.png');
else
    fullscreen(A,fs);
end

end