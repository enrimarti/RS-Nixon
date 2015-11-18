item_based=item_based();
mask=not(logical(urm));
item_based=mask.*item_based;

precomp_urm=item_based+urm;

sim=pearson();
n_user=count(urm~=0,2);
mask=not(mask);
overlapped=mask*mask';

sw = compute_sw(n_user);
m = compute_m(n_user);

harm_num=m*m';


temp=repmat(n_user,1,size(urm,2)); %%TODO: check this out
harm_den=temp+temp';
harm=hrm_num.*harm_den;

sg=compute_sg(overlapped);

%%remove main diagonal
diff=speye(harm);
harm=harm-diff;

sum_temp = harm.*sim;
sum = sum_temp * precomp_urm'; %%TODO: check this out

content_contrib=bsxfun(@minus,precomp_urm,sw) %%should do the minus between columns
rec_num=content_contrib+sum;

rec_den=bsxfun(@plus,sum_temp,sw);

rec=num./den;


