clear all;
% Read the input file
% Read the file
data = readlines("Test.txt");
map = strrep(data, '#', '9');
map = strrep(map, '.', '0');
map = strrep(map, 'S', '1');
map = strrep(map, 'E', '2');
map = char(map)



for i = 1:height(map)
    for j = 1:width(map)
        grid(i,j) = str2double(map(i,j));
    end
end

[startRow,startCol] = find(grid==1)
[endRow,endCol] = find(grid==2)
visited = ones(height(grid),width(grid),4)*99999
queue = [startRow,startCol,2,0]
%1 är uppåt
%2 är höger
%3 är ner
%4 är vänster
iterations = 0;
while  any(visited(:) == 99999) 
    iterations = iterations +1;
    tempQ = [];
    for i = 1:height(queue)
        if queue(i,1)-1>0 && grid(queue(i,1)-1,queue(i,2))~=9
             rotCost = min(abs(queue(i,3)-1)*1000,abs(queue(i,3)-4-1)*1000);
            if visited(queue(i,1)-1,queue(i,2),1) >= queue(i,4)+1+rotCost
                tempQ = [tempQ; queue(i,1)-1, queue(i,2), 1 ,queue(i,4)+1+rotCost];
                visited(queue(i,1)-1,queue(i,2),1) = queue(i,4)+1+rotCost;
            end
        
        end
        if queue(i,2)+1<=width(grid) && grid(queue(i,1),queue(i,2)+1)~=9
            rotCost = min(abs(queue(i,3)-2)*1000,abs(queue(i,3)-4-2)*1000);
             if visited(queue(i,1),queue(i,2)+1,2) >= queue(i,4)+1+rotCost
                tempQ = [tempQ; queue(i,1), queue(i,2)+1, 2 , queue(i,4)+1+rotCost];
                visited(queue(i,1),queue(i,2)+1,2) = queue(i,4)+1+rotCost;
             end
        end
        if queue(i,1)+1<=height(grid) && grid(queue(i,1)+1,queue(i,2))~=9
            rotCost = min(abs(queue(i,3)-3)*1000,abs(queue(i,3)-4-3)*1000);
             if visited(queue(i,1)+1,queue(i,2),3) >= queue(i,4)+1+rotCost
            tempQ = [tempQ; queue(i,1)+1, queue(i,2), 3 , queue(i,4)+1+rotCost];
                visited(queue(i,1)+1,queue(i,2),3) = queue(i,4)+1+rotCost;
             end
        end
         if queue(i,2)-1>0 && grid(queue(i,1),queue(i,2)-1)~=9
            rotCost = min(abs(queue(i,3)-4)*1000,abs(queue(i,3)-4+4)*1000);
             if visited(queue(i,1),queue(i,2)-1,4) >= queue(i,4)+1+rotCost
            tempQ = [tempQ; queue(i,1), queue(i,2)-1, 4 , queue(i,4)+1+rotCost];
            visited(queue(i,1),queue(i,2)-1,4) = queue(i,4)+1+rotCost;
             end
        end
    end
    if ~isempty(tempQ)
    sortedData = sortrows(tempQ, [1, 2, 3, 4]);
    [~, uniqueIdx] = unique(sortedData(:, 1:3), 'rows', 'first');
    result = sortedData(uniqueIdx, :);
    queue= result;
    else
    break
    end

end

resultArray = min(visited, [], 3)
resultArray(endRow,endCol)


%%
% Initialize variables for backtracking
minCost = resultArray(endRow, endCol);
currentNodes = [endRow, endCol];
visitedNodes = false(height(grid), width(grid)); % Tracks visited cells
visitedNodes(endRow, endCol) = true;

% Backtracking to find all unique nodes on shortest paths
while ~isempty(currentNodes)
    tempNodes = [];
    for i = 1:size(currentNodes, 1)
        r = currentNodes(i, 1);
        c = currentNodes(i, 2);

        % Check all neighbors
        neighbors = [
            r-1, c;   % Up
            r+1, c;   % Down
            r, c-1;   % Left
            r, c+1    % Right
        ];
        
        for j = 1:size(neighbors, 1)
            nr = neighbors(j, 1);
            nc = neighbors(j, 2);

            % Ensure neighbor is within bounds and has correct cost
            if nr > 0 && nr <= height(grid) && nc > 0 && nc <= width(grid)
                neighborCost = resultArray(nr, nc);
                if neighborCost + 1 == resultArray(r, c) && ~visitedNodes(nr, nc)
                    tempNodes = [tempNodes; nr, nc];
                    visitedNodes(nr, nc) = true; % Mark as visited
                end
            end
        end
    end
    currentNodes = tempNodes; % Update current nodes to new layer
end

% Count unique visited cells
numUniqueNodes = sum(visitedNodes(:));
disp(['Number of unique nodes on all shortest paths: ', num2str(numUniqueNodes)]);
