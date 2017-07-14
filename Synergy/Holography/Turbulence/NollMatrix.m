function [ I ] = NollMatrix( nm )
%NOLLMATRIX Returns the Noll matrix value I at position [n, m]
n = nm(1,1);
m = nm(1,2);
I = (0.15337 * (-1)^(n-m) * (n+1) * gamma(14/3) * gamma(n-5/6)) / (gamma(17/6)^2 * gamma(n+23/6)); 
%I = (gamma(14/3)*gamma((n+m-14/3+3)/2))/(2^(14/3)*gamma((-n+m+14/3+1)/2)*gamma((n-m+14/3+1)/2)*gamma((n+m+14/3+3)/2));
end

