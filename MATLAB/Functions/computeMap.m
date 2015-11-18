function[value] = computeMap (submission,groundTruth)
subID=fopen(submission,'r');
groID=fopen(groundTruth,'r');
recommendation = textscan(subID,'%d, %d %d %d %d %d');
ground_truth = textscan(groID,'%d, %d %d %d %d %d');
recommendation=cell2mat(recommendation);
ground_truth=cell2mat(ground_truth);

value=0;
for i=1:size(recommendation,1)
    rec=recommendation(i,2:end);
    truth=ground_truth(i,2:end);
    value=value+mapAt5(rec,truth);
end
value=value/size(recommendation,1);





