function ComplexFigure( complexMatrix )
%COMPLEXFIGURE Displays a complex 2D matrix nicely.

figure;
subplot(1,2,1)
imshow(abs(complexMatrix),'Border','tight','InitialMagnification','fit');
title('Magnitude')
subplot(1,2,2)
imshow(uint8(angle(complexMatrix)*(127.5/pi)+127.5),'Border','tight','InitialMagnification','fit');
title('Phase')
end

