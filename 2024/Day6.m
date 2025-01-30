clear all;
data = readlines("Input.txt");
grid = char(data);
loops = 0;
tic
for i = 1:height(grid)
    for j = 1:width(grid)
        flag = true;
        counter = 0;
        grid = char(data);
        guarddir = 0;
        [gRow, gCol] = find(grid == '^');
        grid(gRow,gCol) = 'x';
        if strcmp(grid(i,j),'#')
            continue
        elseif strcmp(grid(i,j),'.')
            grid(i,j) = '#';
        else
            continue
        end
        while counter < 10000 && flag
            if guarddir == 0
                if gRow == 1
                    flag = false;
                    continue
                end
                if strcmp(grid(gRow-1,gCol),'.') || strcmp(grid(gRow-1,gCol),'x')
                    grid(gRow-1,gCol) = 'x';
                    gRow = gRow-1;
                else
                    guarddir = guarddir + 1;
                end
            elseif guarddir == 1
                if gCol == length(grid)
                    flag = false;
                    continue
                end
                if strcmp(grid(gRow,gCol+1),'.') || strcmp(grid(gRow,gCol+1),'x')
                    grid(gRow,gCol+1) = 'x';
                    gCol = gCol +1;
                else
                    guarddir = guarddir + 1;
                end
            elseif guarddir == 2
                if gRow == height(grid)
                    flag = false;
                    continue
                end
                if strcmp(grid(gRow+1,gCol),'.') || strcmp(grid(gRow+1,gCol),'x')
                    grid(gRow+1,gCol) = 'x';
                    gRow = gRow+1;
                else
                    guarddir = guarddir + 1;
                end
            elseif guarddir == 3
                if gCol == 1
                    flag = false;
                    continue
                end
                if strcmp(grid(gRow,gCol-1),'.') || strcmp(grid(gRow,gCol-1),'x')
                    grid(gRow,gCol-1) = 'x';
                    gCol = gCol-1;
                else
                    guarddir = guarddir + 1;
                end
            end
            if guarddir > 3
                guarddir = 0;
            end
            counter = counter +1;
        end
        if counter == 7000
            loops = loops +1;
        end
    end
end

part2 = length(find(grid=='x'))
toc