function sg =compute_sg(matrix)

k=50

sg=matrix;
sg(sg>=k)=0;
sg=sg/k;
sg(sg==0)=1;