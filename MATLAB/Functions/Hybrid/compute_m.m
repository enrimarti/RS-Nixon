function m = compute_m (matrix)
k=50;

m = matrix;
m(m>k)=0;
m=m/k;
m(m==0)=1;

