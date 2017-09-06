function [ I ] = NollMatrix( n, m )
%NOLLMATRIX Returns the Noll matrix value I at position [n, m]
I = (0.15337 .* (-1).^(n-m) .* (n+1) .* gamma(14/3) .* gamma(n-5/6)) ./ (gamma(17/6)^2 .* gamma(n+23/6)); 
end

