[urm,test_users]=load_data('train_no_header.csv','test_no_header.csv',0);

[icm,~]=load_data('icm_no_header.csv','test_no_header.csv',0);


norm=sqrt(sum(icm .^ 2,2));

icm1=icm(1:18570,1:end);
icm2=icm(18571:end,1:end);

norm1=sqrt(sum(icm1 .^ 2,2));
norm2=sqrt(sum(icm2 .^ 2,2));

num1=icm1*icm';
num2=icm2*icm';

den1=norm1*norm';
den2=norm2*norm';

sim1=num1./den1;
sim2=num2./den2;

sim1(isnan(sim1))=0;
sim2(isnan(sim2))=0;

rec1=urm*sim1';
rec2=urm*sim2';




