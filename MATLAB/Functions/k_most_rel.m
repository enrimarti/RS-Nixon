function [sim] = k_most_rel (sim, k)
%returns the sim matrix with only the k most relevant similarity

%creates the index matrix
[~, idx] = sort(sim,2,'descend');

%takes only the irrelevant values 
idx=idx(:,k+1:end);

%some math to create a vector of index
tmp = idx-1;
tmp=tmp*size(idx,1);
v=(1:size(idx,1))';
tmp=bsxfun(@plus,tmp,v);
tmp=reshape(tmp,[numel(tmp),1]);

%all the irrelevant values set to 0
sim(tmp)=0;

end




