function [ SignalNoise ] = OffDiagSum( mat )
%OFFDIAGSUM Sum the elements of each row, excluding the diagonal (1,1),
%(2,2), etc. Returns a matrix where the first column (:,1) is the diagonal
%value and the second column (:,2) is the off diagonal sum.

rows = size(mat,1);

SignalNoise = zeros(rows, 2);

zerodiag = ones(rows);
zerodiag(logical(eye(size(zerodiag)))) = 0;

nodiagmat = mat .* zerodiag;

for row = 1 : size(mat,1)
    SignalNoise(row,1) = mat(row,row);
    SignalNoise(row,2) = sum(nodiagmat(row,:));
end

end

