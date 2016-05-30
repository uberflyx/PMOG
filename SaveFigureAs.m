function [ ] = SaveFigureAs( filename )
%SAVEFIGUREAS Grabs the last created figure and saves as a file as specified.

frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);

imwrite(imind,cm,filename);
end

