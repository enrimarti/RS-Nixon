function create_submission (filename, recommendations, test_users)

%%filename: name of the submission
%%recommendations: matrix of  recommendations
%%test_users: set of test users 
%%
%%creates two files: the first one is the submission, the second one is a
%%values file.
fileID = fopen(filename,'w');
fprintf(fileID,'userId,testItems\n');
valueFileID = fopen(strcat('values_',filename),'w');
fprintf(valueFileID,'userId,testValues\n');
for i = 1:size(test_users,1)
    row=recommendations(i,:);
    [sortedValues,sortIndex]=sort(row,'descend');
    user=test_users(i);
    indexes=sortIndex(1:5);
    values= full(sortedValues(1:5));
    fprintf(fileID,'%d, %d %d %d %d %d\n',user,indexes);
    fprintf(valueFileID,'%d, %d %d %d %d %d\n',user,values);
end
fclose(fileID);
fclose(valueFileID);
