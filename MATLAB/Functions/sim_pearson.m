function[sim1,sim2]=sim_pearson(urm,shrink)

irm=urm';
bin_urm=logical(urm);

[irm1,irm2]=split_row(irm);

num1=irm1*urm;
num2=irm2*urm;

den1=(irm1.*irm1)*bin_urm;
den2=(irm2.*irm2)*bin_urm;

den1_temp=den1';
den2_temp=den2';

[den11_temp,den21_temp]=split_row(den1_temp);
[den12_temp,den22_temp]=split_row(den2_temp);

den1_trans=[den11_temp den12_temp];
den2_trans=[den21_temp den22_temp];

den1=sqrt(den1.*den1_trans)+shrink;
den2=sqrt(den2.*den2_trans)+shrink;

sim1=num1./den1;
sim2=num2./den2;

sim1(isnan(sim1))=0;
sim2(isnan(sim2))=0;


