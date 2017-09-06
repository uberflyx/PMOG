function [ weights, n, m ] = ZernikeWeightsKolmogorov( D, r0, terms )
%ZERNIKEWEIGHTSKOLMOGOROV Returns a random set of weights for zernike
%polynomials, similar to the KolmogorovTurb function.
% Based on algorithm described in the Burger et al, South African Journal
% of Science 104,129-134 (2008) & Noll, J. Opt. Soc. Am. 66,207-211 (1976).

if nargin < 3
    terms = 44;
end

n = [];
m = [];
for zIndex = 2:(terms+1)
    nm = zernIndex(zIndex);
    n = [n nm(1)];
    m = [m nm(2)];
end

I = NollMatrix(n,m);
sigmas = sqrt(I .* (D/r0)^(5/3));
randoms = randn(1,size(sigmas,2));
weights = sigmas .* randoms;

end

