function[value]= mapAt5(rec,truth)
value=0;
for i=1:5
    value=value+size(intersect(rec(1:i),truth(1:i)),2)/i;
end
value=value/5;