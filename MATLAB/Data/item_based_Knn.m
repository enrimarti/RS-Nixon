[urm,test_users]=load_data('train_no_header.csv','test_no_header.csv',0);
%[icm,~]=load_data('icm_no_header.csv','test_no_header.csv',0);


%computing similarity
irm=urm';

sim_num=irm*irm';

%bin_irm=irm;
%bin_irm(bin_irm>0)=1;

norm=sqrt(sum(irm .^ 2,2));


