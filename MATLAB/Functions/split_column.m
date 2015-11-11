function [matrix1 matrix2] = split_column(matrix)

n_column = size(matrix,2);

matrix1=matrix(:,1:floor(n_column/2));
matrix2=matrix(:,floor(n_column/2)+1:end);
