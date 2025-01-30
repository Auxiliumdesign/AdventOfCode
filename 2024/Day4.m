clear all;
data = readlines("Input.txt");

grid = char(data);
len = length('XMAS');
Part1 = 0

for row = 1:height(grid) 
    for col = 1:width(grid)-len+1
        word = grid(row,col:col+len-1);
        if strcmp(word,'XMAS') || strcmp(word,'SAMX')
            Part1 = Part1 + 1 ;
        end
    end
end
for col = 1:width(grid)
    for row = 1:height(grid)-len+1
        word = transpose(grid(row:row+len-1,col));
        if strcmp(word,'XMAS') || strcmp(word,'SAMX')
            Part1 = Part1 + 1 ;
        end
    end
end
for col = 1:width(grid)-len+1
    for row = 1:height(grid)-len+1
        diag1 = [grid(col,row),grid(col+1,row+1),grid(col+2,row+2),grid(col+3,row+3)];
        diag2 = [grid(col,row+3),grid(col+1,row+2),grid(col+2,row+1),grid(col+3,row)];
        if strcmp(diag1,'SAMX') || strcmp(diag1,'XMAS')
            Part1 = Part1 + 1;
        end
        if strcmp(diag2,'SAMX') || strcmp(diag2,'XMAS')
            Part1 = Part1 + 1;
        end

    end
end

%% Part 2

word = 'MAS';
len = length(word);
Part2 = 0;
for col = 1:width(grid)-len+1
    for row = 1:height(grid)-len+1
        diag1 = [grid(col,row+2),grid(col+1,row+1),grid(col+2,row)];
        diag2 = [grid(col,row),grid(col+1,row+1),grid(col+2,row+2)];
        if (strcmp(diag1,'MAS') || strcmp(diag1,'SAM')) && (strcmp(diag2,'MAS') || strcmp(diag2,'SAM'))
            Part2 = Part2 + 1;
        end
    end
end
