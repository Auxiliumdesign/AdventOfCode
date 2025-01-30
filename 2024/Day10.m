clear all;
% Read the input file
% Read the file
data = readlines("Input.txt");
for i = 1:height(data)
    grid(i, :) = arrayfun(@str2double, char(data(i)));
end

part1 = 0
part2 = 0
[row,col] = find(grid==0)
gw = width(grid);
for i = 1:height(row)
    stack = [row(i),col(i),0]
    while ~isempty(stack)
    tempStack = [];
    for j = 1:height(stack)


        if stack(j,1)+1 <= gw
            if grid(stack(j,1)+1,stack(j,2)) == stack(j,3)+1
                tempStack = [tempStack;stack(j,1)+1,stack(j,2),stack(j,3)+1];
            end
        end
        if stack(j,2)+1 <= gw
            if grid(stack(j,1),stack(j,2)+1) == stack(j,3)+1
                tempStack = [tempStack;stack(j,1),stack(j,2)+1,stack(j,3)+1];
            end
        end
        if stack(j,1)-1 > 0
            if grid(stack(j,1)-1,stack(j,2)) == stack(j,3)+1
                tempStack = [tempStack;stack(j,1)-1,stack(j,2),stack(j,3)+1];
            end
        end
        if stack(j,2)-1 > 0
            if grid(stack(j,1),stack(j,2)-1) == stack(j,3)+1
                tempStack = [tempStack;stack(j,1),stack(j,2)-1,stack(j,3)+1];
            end
        end
    end
    if ~isempty(find(tempStack == 9))
    B = unique(tempStack, 'rows');
    part2 = part2 + length(find(B(:,3) == 9));
    part1 = part1 + length(find(tempStack(:,3) == 9));
    end
    stack = tempStack;
    end
end

