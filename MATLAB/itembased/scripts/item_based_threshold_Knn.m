[urm,test_users]=load_data('train_no_header.csv','test_no_header.csv',0);

%Computing similarity matrix
irm=urm';

[irm1 irm2]=split_row(irm);

%%%%%%% Removing average from similarity definition

irm_mask1= logical(irm1);
irm_mask2= logical(irm2);

avg=mean(irm,1);


diff_avg1=bsxfun(@minus,irm1,avg);
avg1_num=diff_avg1.*irm_mask1;

diff_avg2=bsxfun(@minus,irm2,avg);
avg2_num=diff_avg2.*irm_mask2;

avg_num=[avg1_num;avg2_num];
num1=avg1_num*avg_num';
num2=avg2_num*avg_num';

diff_avg1_sq=diff_avg1.*diff_avg1;
avg1_den=diff_avg1_sq.*irm_mask1;
norm1=sum(avg1_den,2);

diff_avg2_sq=diff_avg2.*diff_avg2;
avg2_den=diff_avg2_sq.*irm_mask2;
norm2=sum(avg2_den,2);

norm=[norm1; norm2];

avg_den=[avg1_den;avg2_den];
den1=sqrt(norm1*norm');
den2=sqrt(norm2*norm');

%%%%%%%


sim1=num1./den1;
sim2=num2./den2;

diff=speye(37142,37142);
[diff1 diff2]=split_row(diff);

sim1=sim1-diff1;
sim2=sim2-diff2;

clearvars num1 num2 den1 den2 irm irm1 irm2 diff1 diff2;

%remove NaN
sim1(isnan(sim1))=0;
sim2(isnan(sim2))=0;



%%filtering by threshold j
[sim11 sim12]=split_row(sim1);
[sim21 sim22]=split_row(sim2);


j=0.2;

sim11=threshold(sim11,j);
sim12=threshold(sim12,j);
sim21=threshold(sim21,j);
sim22=threshold(sim22,j);

sim1=[sim11;sim12];
sim2=[sim21;sim22];

%%applying k-NN
k=200;

sim1=k_most_rel(sim1,k);
sim2=k_most_rel(sim2,k);

num_rec1=urm*sim1';
num_rec2=urm*sim2';

bin_urm=urm;
bin_urm(bin_urm>0)=1;

den_rec1=bin_urm*sim1';
den_rec2=bin_urm*sim2';

tot1=num_rec1./den_rec1;
tot2=num_rec2./den_rec2;

clearvars den_rec1 den_rec2 num_rec1 num_rec2;

%avoid to recommend already seen movies and sort the element
not_bin_urm=not(bin_urm);

[not_bin_urm1 not_bin_urm2]=split_column(not_bin_urm);

test_1=tot1(test_users,1:18571);
test_2=tot2(test_users,18572:end);

tot1=tot1.*not_bin_urm1;
tot2=tot2.*not_bin_urm2;

[tot11 tot12]=split_row(tot1);
[tot21 tot22]=split_row(tot2);

tot1=[tot11,tot21];
tot2=[tot12,tot22];

test1=test_users(1:2085,:);
test2_temp=test_users(2086:end,:);
test2=test2_temp-7687;

test_tot1=tot1(test1,:);
test_tot2=tot2(test2,:);
test_tot=[test_tot1;test_tot2];
test_tot(isnan(test_tot))=0;


filename='sub_item_based_norm_J20_K200.csv';
path='../outputs/';
filename=strcat(path,filename);

%%%%%%% build the submission
create_submission(filename,test_tot,test_users);