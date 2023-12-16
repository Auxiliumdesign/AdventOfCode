clear all

data = readlines("Input.txt")
data = char(data)
%% Part 1
total = 0
startNum = 0
for row = 1:height(data)
    for col = 1:width(data)
        if isempty(str2num(data(row,col)))
            if startNum ~= 0
                if getNeighbors(data,row,startNum,endNum)
                    total = total + number;
                end
                startNum = 0;
                number = 0;
                endNum = 0;
            end
        elseif startNum == 0
            startNum = col;
            endNum = col;
            number = str2double(data(row,col));
        else
            endNum = col;
            number = number*10 + str2double(data(row,col));
            if col == width(data)
                if getNeighbors(data,row,startNum,endNum)
                    total = total + number;
                end
                startNum = 0;
                number = 0;
                endNum = 0;
            end
        end
    end
end
part1 = total
%% Part 2
total = 0
startNum = 0
endNum = 0
indexData = []
numData = []
for row = 1:height(data)
    for col = 1:width(data)
        if isempty(str2num(data(row,col)))
            if startNum ~= 0
                for rows = max(1,row-1) : min(row+1,height(data))
                    for cols = max(1,startNum-1) : min(endNum+1,width(data))
                        if data(rows,cols) == "*"
                            indexData = [indexData, sub2ind([height(data),width(data)],cols,rows)];
                            numData = [numData, number];
                        end
                    end
                end
                startNum = 0;
                number = 0;
                endNum = 0;
            else

            end
        elseif startNum == 0
            startNum = col;
            endNum = col;
            number = str2double(data(row,col));
        else
            endNum = col;
            number = number*10 + str2double(data(row,col));
        end
    end
end
[GC,GR] = groupcounts(indexData');
GD = GR(GC==2);
sumGear = 0;
for i = 1:height(GD)
    index = find(indexData'==GD(i));
    gearRatio = numData(index(1)) * numData(index(2));
    sumGear = sumGear + gearRatio;
end
part2 = sumGear

function symNeigh = getNeighbors(charArray, row, startCol, endCol)
[numRows, numCols] = size(charArray);
neighbors = [];
if row > 1
    neighbors = [neighbors, charArray(row-1, max(startCol-1, 1):min(endCol+1, numCols))];
end
if row < numRows
    neighbors = [neighbors, charArray(row+1, max(startCol-1, 1):min(endCol+1, numCols))];
end
if startCol > 1
    neighbors = [neighbors, charArray(row, startCol-1)];
end
if endCol < numCols
    neighbors = [neighbors, charArray(row, endCol+1)];
end
symNeigh = any(neighbors ~= '.');
end
