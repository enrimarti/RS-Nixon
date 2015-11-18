%[urm,test_users]=load_data('train_no_header.csv','test_no_header.csv',0);
urm=[9 0 2 5;0 1 0 7;3 0 0 8;0 5 0 0];
[urm1,urm2]=split_row(urm);

%item_based=item_based();
item_based=[6 3 2 4; 7 5 4 5; 4 5 6 8; 9 3 2 4];
[item_based1,item_based2]=split_row(item_based);

mask=not(logical(urm));
[mask1, mask2]=split_row(mask);

item_based1=mask1.*item_based1;
item_based2=mask2.*item_based2;


precomp_urm1=item_based1+urm1;
precomp_urm2=item_based2+urm2;

[sim1,sim2]=sim_pearson(urm);


n_user=count(urm~=0,2);


mask=not(mask);
[mask1,mask2]=split_column(mask);

overlapped1=mask1*mask1';
overlapped2=mask2*mask2';


sw = compute_sw(n_user);
m = compute_m(n_user);

harm_num=m*m';
[harm_num1,harm_num2]=split_row(harm_num);


temp=repmat(n_user,1,size(urm,2)); %%TODO: check this out
harm_den=temp+temp';
[harm_den1,harm_den2]=split_column(harm_den);

harm1=hrm_num1.*harm_den1;
harm2=hrm_num2.*harm_den2;

sg1=compute_sg(overlapped1);
sg2=compute_sg(overlapped2);


%%remove main diagonal
diff=speye(harm);
[diff1, diff2]=split_row(diff);

harm1=harm1-diff1;
harm2=harm2-diff2;

sum_temp1 = harm1.*sim1;
sum_temp2 = harm2.*sim2;

sum1 = sum_temp1 * precomp_urm1';%%TODO: check this out
sum2 = sum_temp2 * precomp_urm2';%%TODO: check this out

content_contrib1=bsxfun(@minus,precomp_urm1,sw) %%should do the minus between columns
content_contrib2=bsxfun(@minus,precomp_urm2,sw) %%should do the minus between columns

rec_num1=content_contrib1+sum1;
rec_num2=content_contrib2+sum2;

rec_den1=bsxfun(@plus,sum_temp1,sw);
rec_den2=bsxfun(@plus,sum_temp2,sw);

rec1=num1./den1;
rec2=num2./den2;

