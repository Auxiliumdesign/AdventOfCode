clear all
fetch
data = readlines("Input.txt");
disp(data)
bingoNums = double(strtrim(strsplit(data(1),',')))
grid = zeros(5,5)
rowCount = 1
boardCount = 1
for i = 3:height(data)
    numbers = double(strsplit(strtrim(data(i))))
    if isnan(numbers)
        boardCount = boardCount +1;
        rowCount = 1;
    else
        grid(rowCount,1:5,boardCount) = numbers;
        rowCount = rowCount +1;
    end
end

boards = zeros(5,5,size(grid,3));

for i = 1:length(bingoNums)
    boards(find(grid == bingoNums(i)))=1
    if any(sum(boards,1) == 5,'all')
        index = find(any(sum(boards,1) == 5))
        break
    elseif any(sum(boards,2) == 5,'all')
        index = find(any(sum(boards,2) == 5))
        break
    end
end

lastNumber = bingoNums(i)
boardGrid = grid(:,:,index)
unmarked = ~boards(:,:,index)
part1= sum(boardGrid.*unmarked,'all')*lastNumber
submit(part1)