function sw = compute_sw (matrix)
max = 2;
k=50;

sw = matrix;
sw(sw >= k) = 0;
sw = sw * max / k; 
sw(sw == 0) = max;

