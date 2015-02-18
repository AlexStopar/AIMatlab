function dist = ManhattenDistance(State)
dist = 0;
for i = 1:8
 goalRow =  floor((i-1)/3);
 goalColumn = mod(i - 1,3);
 j = find(State == i);
 currentRow = floor((j - 1)/3);
 currentColumn = mod(j - 1,3);
 dist = dist + abs(goalRow - currentRow) + abs(goalColumn - currentColumn);
end


