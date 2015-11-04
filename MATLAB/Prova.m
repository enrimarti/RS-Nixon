A=[1 2 3; 4 5 6; 7 8 9; 10 11 12]

A1=A(1:end/2,1:end)
A2=A(end/2+1:end,1:end)

A3=sum(A,1)

a4=sort(A,1,'descend')