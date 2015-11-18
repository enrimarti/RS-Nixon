[urm,~]=load_data('train_no_header.csv','test_no_header.csv',0);

%removing users with less than 6 positive ratings
pos_bin_urm1=urm(1:7687,:);
pos_bin_urm2=urm(7688:end,:);

pos_bin_urm1(pos_bin_urm1<8)=0;
pos_bin_urm1(pos_bin_urm1>0)=1;

pos_bin_urm2(pos_bin_urm2<8)=0;
pos_bin_urm2(pos_bin_urm2>0)=1;


vote_count1=sum(pos_bin_urm1,2);
vote_count2=sum(pos_bin_urm2,2);
vote_count=[vote_count1;vote_count2];
vote_count(vote_count<6)=0;

%Computing number of rates for each item
irm=urm';

item_bin_irm1=irm(1:18570,:);
item_bin_irm2=irm(18571:end,:);

item_bin_irm1=logical(item_bin_irm1);
item_bin_irm2=logical(item_bin_irm2);

item_vote_count1=sum(item_bin_irm1,2);
item_vote_count2=sum(item_bin_irm2,2);

item_vote_count=[item_vote_count1;item_vote_count2];

[sortedValues,sortIndex]=sort(item_vote_count,'ascend');
%select 20% users for test
total_users=nnz(vote_count1)+nnz(vote_count2);
n=floor(total_users*0.2);
indexes=zeros(n,1);
i=1;
while i<=n
    index=randi(15374);
    if vote_count(index)>0
        indexes(i)=index;
        i=i+1;
    end
end   

new_urm=urm;
items=zeros(2735,5);
for i=1:n
    j=1;
    k=1;
    while and(j<=37142,k<6)
        if urm(indexes(i),sortIndex(j))>=8
            items(i,k)=sortIndex(j);
            new_urm(indexes(i),sortIndex(j))=0;
            k=k+1;
        end
        j=j+1;
    end
end


[u,i,r]=find(new_urm);
fileID = fopen('new_urm.csv','w');
csv_input=[u i r];
for i=1:size(csv_input,1)
    fprintf(fileID,'%d,%d,%d\n',csv_input(i,:)); 
end
fclose(fileID);

fileID= fopen('ground_truth.csv','w');
testID= fopen('new_test.csv','w');
for i=1:n
    fprintf(fileID,'%d, %d %d %d %d %d\n',indexes(i),items(i,:));
    fprintf(testID,'%d\n',indexes(i));
end
fclose(fileID); 
fclose(testID);


