clear all;
% Read the input file
% Read the file
map = readlines("InputMap.txt");
map = strrep(map, '#', '9');
map = strrep(map, '@', '1');
map = strrep(map, 'O', '2');
map = strrep(map, '.', '0');
map = char(map);
moves = fileread("InputMoves.txt");
moves = strrep(moves, '^', '1');
moves = strrep(moves, '>', '2');
moves = strrep(moves, 'v', '3');
moves = strrep(moves, '<', '4');

for i = 1:width(moves)
    mov(i) = str2double(moves(i));
end

for i = 1:height(map)
    for j = 1:width(map)
        grid(i,j) = str2double(map(i,j));
    end
end
% robot is 1
% air is 0
% wall is 9
% O is 2
[robRow,robCol] = find(grid==1);
grid(grid==1)=0;

for i = 1:length(mov)
    if mov(i) == 1
        firstAir = find(grid(1:robRow-1,robCol)==0,1,"last");
        firstWall = find(grid(1:robRow-1,robCol)==9,1,"last");
        if firstAir > firstWall
            if firstAir < robRow-1
                grid(firstAir,robCol) = 2;
                grid(robRow-1,robCol) = 0;
            end
            robRow = robRow - 1;
        end
    end
    if mov(i) == 2
        firstAir = find(grid(robRow,robCol+1:end)==0,1,"first");
        firstWall = find(grid(robRow,robCol+1:end)==9,1,"first");
        if firstAir < firstWall
            if firstAir > 1
                grid(robRow,firstAir+robCol) = 2;
                grid(robRow,robCol+1) = 0;
            end
            robCol = robCol + 1;
        end
    end
    if mov(i) == 3
        firstAir = find(grid(robRow+1:end,robCol)==0,1,"first");
        firstWall = find(grid(robRow+1:end,robCol)==9,1,"first");
        if firstAir < firstWall
            if firstAir > 1
                grid(firstAir+robRow,robCol) = 2;
                grid(robRow+1,robCol) = 0;
            end
            robRow = robRow + 1;
        end
    end
    if mov(i) == 4
        firstAir = find(grid(robRow,1:robCol-1)==0,1,"last");
        firstWall = find(grid(robRow,1:robCol-1)==9,1,"last");
        if firstAir > firstWall
            if firstAir < robCol-1
                grid(robRow,firstAir) = 2;
                grid(robRow,robCol-1) = 0;
            end
            robCol = robCol - 1;
        end
    end
end

sum=0;
for i = 1:height(grid)
    for j = 1:width(grid)
        if grid(i,j) == 2
            sum = sum + 100*(i-1)+j-1;
        end
    end
end

%%

clear all;
% Read the input file
% Read the file
map = readlines("InputMap.txt");
map = strrep(map, '#', '9');
map = strrep(map, '@', '1');
map = strrep(map, 'O', '2');
map = strrep(map, '.', '0');
map = char(map);
moves = fileread("InputMoves.txt");
moves = strrep(moves, '^', '1');
moves = strrep(moves, '>', '2');
moves = strrep(moves, 'v', '3');
moves = strrep(moves, '<', '4');

for i = 1:width(moves)
    mov(i) = str2double(moves(i));
end
wallCounter = 2;
for i = 1:height(map)
    for j = 1:width(map)
        if map(i,j) == '2'
            grid(i,j) = wallCounter
            wallCounter = wallCounter +1
        elseif map(i,j) == '9'
            grid(i,j) = 999;
        else

            grid(i,j) = str2double(map(i,j));
        end
    end
end


j = 1;
for i = 1:width(map)
    wideGrid(:,j) = grid(:,i);
    wideGrid(:,j+1) = grid(:,i);
    j = j +2;
end


% robot is 1
% air is 0
% wall is 9
% O is 2
grid = wideGrid
[robRow,robCol] = find(grid==1);
robRow = robRow(1)
robCol = robCol(1)
grid(grid==1)=0;

for i = 1:length(mov)
    % if mov(i) == 1
    %     firstAir = find(grid(1:robRow-1,robCol)==0,1,"last");
    %     firstWall = find(grid(1:robRow-1,robCol)==999,1,"last");
    %     if firstAir > firstWall
    %         if firstAir < robRow-1
    %             grid(firstAir,robCol) = 2;
    %             grid(robRow-1,robCol) = 0;
    %         end
    %         robRow = robRow - 1;
    %     end
    % end

    if mov(i) == 1
        firstAir = find(grid(1:robRow-1,robCol)==0,1,"last");
        firstWall = find(grid(1:robRow-1,robCol)==999,1,"last");
        if firstAir > firstWall
            % Vi träffar en låda
            if firstAir < robRow-1
                hitWall = false;
                origGrid = grid;
                [boxRow,boxCol] = find(grid==grid(robRow-1,robCol));
                stackNumber = grid(sub2ind(size(grid), boxRow, boxCol));
                grid(grid==grid(robRow-1,robCol))=0;
                stackRow = boxRow;
                stackCol = boxCol;

                while ~isempty(stackNumber)
                    boxNumberUnder = [];
                    for j = 1:height(stackCol)
                        if grid(stackRow(j)-1,stackCol(j)) == 999
                            hitWall = true;
                            break
                        elseif grid(stackRow(j)-1,stackCol(j)) ~= 0
                            boxNumberUnder(j) = grid(stackRow(j)-1,stackCol(j));
                        end
                    end
                    boxNumberUnder = boxNumberUnder(boxNumberUnder ~= 0);
                    boxRow  =[];
                    boxCol = [];
                    uniqueBoxes = [];
                    if ~isempty(boxNumberUnder)
                        uniqueBoxes = unique(boxNumberUnder);
                        [boxRow, boxCol] = find(ismember(grid, uniqueBoxes));
                    end
                    TempstackRow = boxRow;
                    TempstackCol = boxCol;
                    TempstackNumber = grid(sub2ind(size(grid), boxRow, boxCol));
                    grid(ismember(grid, stackNumber)) = 0;
                    for j = 1:height(stackCol)
                        grid(stackRow(j)-1,stackCol(j)) = stackNumber(j);
                    end
                    stackRow = TempstackRow;
                    stackCol = TempstackCol;
                    stackNumber = TempstackNumber;
                    stackNumber;
                end
                if hitWall == false
                    robRow = robRow - 1;
                else
                    grid = origGrid;
                end
            else
                robRow = robRow - 1;
            end

        end
    end


    %klar
    if mov(i) == 2
        firstAir = find(grid(robRow,robCol+1:end)==0,1,"first");
        firstWall = find(grid(robRow,robCol+1:end)==999,1,"first");
        if firstAir < firstWall
            if firstAir > 1
                grid(robRow,robCol+2:firstAir+robCol) = grid(robRow,robCol+1:firstAir+robCol-1);
                grid(robRow,robCol+1) = 0;
            end
            robCol = robCol + 1;
        end
    end

    if mov(i) == 3
        firstAir = find(grid(robRow+1:end,robCol)==0,1,"first");
        firstWall = find(grid(robRow+1:end,robCol)==999,1,"first");
        if firstAir < firstWall
            % Vi träffar en låda
            if firstAir > 1
                hitWall = false;
                origGrid = grid;
                [boxRow,boxCol] = find(grid==grid(robRow+1,robCol));
                stackNumber = grid(sub2ind(size(grid), boxRow, boxCol));
                grid(grid==grid(robRow+1,robCol))=0;
                stackRow = boxRow;
                stackCol = boxCol;

                while ~isempty(stackNumber)
                    boxNumberUnder = [];
                    for j = 1:height(stackCol)
                        if grid(stackRow(j)+1,stackCol(j)) == 999
                            hitWall = true;
                            break
                        elseif grid(stackRow(j)+1,stackCol(j)) ~= 0
                            boxNumberUnder(j) = grid(stackRow(j)+1,stackCol(j));

                        end
                    end
                    boxNumberUnder = boxNumberUnder(boxNumberUnder ~= 0);
                    boxRow  =[];
                    boxCol = [];
                    uniqueBoxes = [];
                    if ~isempty(boxNumberUnder)
                        uniqueBoxes = unique(boxNumberUnder);
                        [boxRow, boxCol] = find(ismember(grid, uniqueBoxes));
                    end
                    TempstackRow = boxRow;
                    TempstackCol = boxCol;
                    TempstackNumber = grid(sub2ind(size(grid), boxRow, boxCol));
                    grid(ismember(grid, stackNumber)) = 0;
                    for j = 1:height(stackCol)
                        grid(stackRow(j)+1,stackCol(j)) = stackNumber(j);
                    end
                    stackRow = TempstackRow;
                    stackCol = TempstackCol;
                    stackNumber = TempstackNumber;
                    stackNumber;

                end
                if hitWall == false
                    robRow = robRow + 1;
                else
                    grid = origGrid;
                end
            else
                robRow = robRow + 1;
            end

        end
    end


    %klar
    if mov(i) == 4
        firstAir = find(grid(robRow,1:robCol-1)==0,1,"last");
        firstWall = find(grid(robRow,1:robCol-1)==999,1,"last");
        if firstAir > firstWall
            if firstAir < robCol-1
                grid(robRow,firstAir:robCol-2) = grid(robRow,firstAir+1:robCol-1);
                grid(robRow,robCol-1) = 0;
            end
            robCol = robCol - 1;
        end
    end
end

visited = []
sum=0;

    for j = 1:width(grid)
        for i = 1:height(grid)
        if grid(i,j) ~= 999 &&grid(i,j) ~= 0 && ~ismember(grid(i,j),visited)
            sum = sum + 100*(i-1)+j-1;
            visited = [visited,grid(i,j)];
        end
    end
end