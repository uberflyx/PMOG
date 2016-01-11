function [] = hologram(N, k, theta, p, l, w, fs)
% Generates Gaussian beam hologram
% N(1), N(2) : number of pixels along each dimension
% k : ??
% theta: grid orientation
% p : radial Order. if p ~= 0 then amplitude is used too.
% l : topological charge. Can be a matrix [1 2; 5 19] will lay them in a
% square. This implies amplitude modulation.
% w : radius
% fs: the screen where to display fullscreen. 0 is a window. ALT-TAB to
% exit fullscreen.
% Examples: 
% hologram([1920 1080], 100, 45, 0, 1, 10, 1)
% hologram([1920 1080], 100, 45, 1, [1 2; 3 4], 0.2, 0)
grid=size(l);
N([1 2])=fliplr(N);
points=N./grid;
range=N/min(N);

p(1:grid(1), 1:grid(2))=p; 
w(1:grid(1), 1:grid(2))=w;
x=linspace(-range(1), range(1), points(1));
y=linspace(-range(2), range(2), points(2));
[yy,xx]=meshgrid(y,x);

amp = 0;
if p ~= 0 
    amp = 1;
end
if max(size(l)) > 1
    amp = 1;
end

A(points(1), grid(1), points(2), grid(2))=uint8(0);
for i=1:grid(1)
    for j=1:grid(2)
        E=LGBeam(p(i,j), l(i,j), w(i,j), xx, yy);
        A(:,i,:,j)=planeWave(E, xx, yy, k, theta, amp);
    end
end
A=reshape(A, N);

if fs == 0
    figure(1); imshow(A,'Border','tight','InitialMagnification','fit'); truesize(1);
    map=gray(256); colormap(map); 
    file = strcat('holograms\hologram-l',int2str(l),'p',int2str(p),'w',int2str(w),'k',int2str(k),'theta',int2str(theta),'.png');
    imwrite(A, map, file);
else
    fullscreen(A,fs);
end

end