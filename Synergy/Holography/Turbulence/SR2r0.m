function [ r0 ] = SR2r0( SR, w0 )
%SR2R0 Returns the r0 (Fried parameter) given the Strehl Ratio and beam waist for
%Kolmogorov turbulence. The unit of r0 is the same as w0 (mm, cm, m, etc.).

r0 = w0/(((1/SR)-1)/6.88)^(3/5);
end

