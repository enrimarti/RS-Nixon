% 
%%%%%%%% PARAMETERS %%%%%%%%%
base_filename = 'item_based'; 
j = 0.38;
step_j = 0.05; 
k = 50; 
step_k = 10; 
N = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path = '../outputs/';
base_filename = strcat(path,base_filename); 

%% TODO: fulfill with actual parameters
salomone();

% precomputation for selected algorithm
%% TODO: fulfill with actual parameters
[] = pre_item_based();

for i=1:N 
    %%base_filename is supposed to be clean from the parameters and .csv
    filename=base_filename;
    filename=strcat(filename,'_J');
    filename=strcat(filename,num2str(j));
    filename=strcat(filename,'_');
    filename=strcat(filename,'_K');
    filename=strcat(filename,num2str(k));
    filename=strcat(filename,'_');
    filename=strcat(filename,'.csv');
    
    %% TODO: modify naming in create_sumbission
    item_based(k,j,output_from_pre);
    
    valutation(filename,ground_truth);
    
    
    j=j-step_j;
    k=k+step_k;


