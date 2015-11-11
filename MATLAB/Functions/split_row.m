function [matrix1 matrix2] = split_row(matrix)

n_row = size(matrix,1);

matrix1=matrix(1:floor(n_row/2),:);
matrix2=matrix(floor(n_row/2)+1:end,:);