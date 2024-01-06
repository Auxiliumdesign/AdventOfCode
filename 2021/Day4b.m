clear all
fetch
data = readlines("Input.txt");
disp(data)
nums = double(strtrim(strsplit(data(1),',')))
grid = zeros(5,5)
rowCount = 1
boardCount = 1
for i = 3:height(data)
    num = double(strsplit(strtrim(data(i))))
    if isnan(num)
        boardCount = boardCount +1;
        rowCount = 1;
    else
        grid(rowCount,1:5,boardCount) = num;
        rowCount = rowCount +1;
    end
end

boards = zeros(5,5,size(grid,3));
wins = zeros(size(grid,3),1)

for i = 1:length(nums)
    boards(find(grid == nums(i)))=1;
    if any(sum(boards,1) == 5,'all')
        index = find(any(sum(boards,1) == 5));
        wins(index) = 1;
    end
    if any(sum(boards,2) == 5,'all')
        index = find(any(sum(boards,2) == 5));
        wins(index) = 1;
    end
    if sum(wins) == size(grid,3)-1
        lastBoard = find(wins == 0);
    elseif sum(wins) == size(grid,3)
         lastNum = nums(i)
         boardGrid = grid(:,:,lastBoard)
         unmarked = ~boards(:,:,lastBoard)
         part2 = sum(boardGrid.*unmarked,'all')*lastNum
         break
    end
end
submit(part2)
