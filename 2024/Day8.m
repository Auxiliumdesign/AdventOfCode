clear all;
% Read the input file
data = readlines("Input.txt");
grid = char(data)
locations = zeros(size(grid))
characters = unique(grid)
for k = 2:height(characters)
    [row,col] = find(grid == characters(k))
    locations(grid==characters(k)) = 1;
    for i = 1:length(row)
        for j = 1:length(row)
            distRow = row(i)-row(j);
            distCol = col(i)-col(j);
            for g = 2:width(grid)
                antinode1 = [row(i)-distRow*g, col(i)-distCol*g];
                antinode2 = [row(j)+distRow*g, col(j)+distCol*g];
                if all(antinode1 <= width(grid)) && all(antinode1 > 0)
                    locations(antinode1(1),antinode1(2)) = 1;
                end
                if  all(antinode2 <= width(grid)) && all(antinode2 > 0)
                    locations(antinode2(1),antinode2(2)) = 1;
                end

            end
        end
    end
end
length(find(locations))


