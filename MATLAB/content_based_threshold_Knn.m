%load data
[urm,test_users]=load_data('train_no_header.csv','test_no_header.csv',0);
[icm,~]=load_data('icm_no_header.csv','test_no_header.csv',0);


icm1=icm(1:18570,1:end);
icm2=icm(18571:end,1:end);

norm=sqrt(sum(icm .^ 2,2));
norm1=sqrt(sum(icm1 .^ 2,2));
norm2=sqrt(sum(icm2 .^ 2,2));

num1=icm1*icm';
num2=icm2*icm';

den1=norm1*norm';
den2=norm2*norm';

sim1=num1./den1;
sim2=num2./den2;

%remove NaN
sim1(isnan(sim1))=0;
sim2(isnan(sim2))=0;

%%filtering by threshold j
j=0.6;

sim1=threshold(sim1,j);
sim2=threshold(sim2,j);

%%applying k-NN
k=10;

sim1=k_most_rel(sim1,k);
sim2=k_most_rel(sim2,k);

%%%use this if you want to use angular distance instead of cosine
%%%similarity (and change variable names accordingly) 
%sim1_norm=acosd(sim1);
%sim1_norm=sim1_norm*2/180;
%sim1_norm=1-sim1_norm;
%sim1_norm=real(sim1_norm);
%sim1_norm=sparse(sim1_norm);
%sim2_norm=acosd(sim2);
%sim2_norm=sim2_norm*2/180;
%sim2_norm=1-sim2_norm;
%sim2_norm=real(sim2_norm);
%sim2_norm=sparse(sim2_norm);

num_rec1=urm*sim1';
num_rec2=urm*sim2';

bin_urm=urm;
bin_urm(bin_urm>0)=1;

den_rec1=bin_urm*sim1';
den_rec2=bin_urm*sim2';

tot1=num_rec1./den_rec1;
tot2=num_rec2./den_rec2;

%avoid to recommend already seen movies and sort the element
not_bin_urm=not(bin_urm);

not_bin_urm1=not_bin_urm(1:end,1:18570);
not_bin_urm2=not_bin_urm(1:end,18571:end);

test_1=tot1(test_users,1:18570);
test_2=tot2(test_users,18571:end);

tot1=tot1.*not_bin_urm1;
tot2=tot2.*not_bin_urm2;

tot11=tot1(1:(end/2),:);
tot12=tot1((end/2+1):end,:);
tot21=tot2(1:(end/2),:);
tot22=tot2((end/2+1):end,:);

tot1=[tot11,tot21];
tot2=[tot12,tot22];

test1=test_users(1:2085,:);
test2_temp=test_users(2086:end,:);
test2=test2_temp-7687;

test_tot1=tot1(test1,:);
test_tot2=tot2(test2,:);
test_tot=[test_tot1;test_tot2];
test_tot(isnan(test_tot))=0;

%save('test_tot.m','test_tot','-v7.3');
%test_tot_copy=test_tot;

%%%%%%% build the submission
fileID = fopen('sub_content_based_norm.csv','w');
for i = 1:4196
    row=test_tot(i,:);
    [sortedValues,sortIndex]=sort(row,'descend');
    user=test_users(i);
    indexes=sortIndex(1:5);
    fprintf(fileID,'%d, %d %d %d %d %d\n',user,indexes);

end
fclose(fileID);