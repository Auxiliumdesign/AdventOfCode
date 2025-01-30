clear all;
data = readlines("Test.txt");
map = strrep(data, '#', '9');
map = strrep(map, '.', '0');
map = strrep(map, 'S', '1');
map = strrep(map, 'E', '2');
map = char(map);
origGrid = double(map)-48;
[wallR,wallC]  = find(origGrid==9);
mask = [0,1,0;1,0,1;0,1,0];
[sR,sC] = find(origGrid==1);
[eR,eC] = find(origGrid==2);
tic
for j = 1:height(wallC)
    queue = [sR,sC];
    steps = 0;
    grid = origGrid;
    if wallR(j) == 1 || wallR(j) == height(grid) || wallC(j) == height(grid) || wallC(j) == 1
        steps = 0;
        stepsPerRem(j) = steps;
        continue
    end
    if  sum(grid(wallR(j)-1:wallR(j)+1,wallC(j)-1:wallC(j)+1) .* mask,"all") > 20
        steps = 0;
        stepsPerRem(j) = steps;
        continue
    end
    grid(wallR(j),wallC(j)) = 0;
while  ~isempty(queue) && ~any(queue(:, 1) == eR & queue(:, 2) == eC)
    tempQ = [];
    for i = 1:height(queue)
        if queue(i,1)-1>0 
            if grid(queue(i,1)-1,queue(i,2)) == 0 || grid(queue(i,1)-1,queue(i,2)) == 2
                tempQ = [tempQ; queue(i,1)-1, queue(i,2)];
                grid(queue(i,1)-1,queue(i,2)) = 1;
            end
        end
        if queue(i,2)+1<=width(grid)
            if grid(queue(i,1),queue(i,2)+1) == 0 || grid(queue(i,1),queue(i,2)+1) == 2
                tempQ = [tempQ; queue(i,1), queue(i,2)+1];
                grid(queue(i,1),queue(i,2)+1) = 1;
            end
        end
        if queue(i,1)+1<=height(grid)
            if grid(queue(i,1)+1,queue(i,2)) == 0 || grid(queue(i,1)+1,queue(i,2)) == 2
                tempQ = [tempQ; queue(i,1)+1, queue(i,2)];
                grid(queue(i,1)+1,queue(i,2)) = 1;
            end
        end
         if queue(i,2)-1>0
            if grid(queue(i,1),queue(i,2)-1) == 0 || grid(queue(i,1),queue(i,2)-1) == 2
                tempQ = [tempQ; queue(i,1), queue(i,2)-1];
                grid(queue(i,1),queue(i,2)-1) = 1;
            end
        end
    end
    queue = tempQ;
    steps = steps+1;
end
stepsPerRem(j) = steps;
end
toc
%%
stepsPerRem(stepsPerRem==0)= max(stepsPerRem);
savings = max(stepsPerRem) - stepsPerRem ;
length(find(savings>=100))

%%

