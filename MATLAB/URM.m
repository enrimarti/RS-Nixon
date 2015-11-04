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

num_rec1=urm*sim1';
num_rec2=urm*sim2';


bin_urm=urm;
bin_urm(bin_urm>0)=1;

den_rec1=bin_urm*sim1';
den_rec2=bin_urm*sim2';

tot1=num_rec1./den_rec1;
tot2=num_rec2./den_rec2;







%%%%%%%%%%%%%%%%
%avoid to recommend already seen movies and sort the element
bin_urm=not(bin_urm);

bin_urm1=bin_urm(1:end,1:18570);
bin_urm2=bin_urm(1:end,18571:end);



test_1=tot1(test_users,1:18570);
test_2=tot2(test_users,18571:end);

%????? 
sort(tes,2,'descent');
sort(tot2,2,'descent');

csvwrite('prova_csv.csv',tot1)
dlmwrite ('prova_csv.csv', full(tot1));
