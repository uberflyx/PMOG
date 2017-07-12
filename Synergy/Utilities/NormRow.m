function [ mat ] = NormRow( mat )
%NORMROW Normalise each row of mat. Row = Row / sum(row).

for row = 1:size(mat,1)
    mat(row,:) = mat(row,:) / sum(mat(row,:));
end

end

