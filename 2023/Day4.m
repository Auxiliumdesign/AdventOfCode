clear all
data = readlines("Input.txt");
numCards = length(data);
for i = 1:numCards
    parts = strsplit(strtrim(data(i)), ' | ');
    leftNumbers(i, :) = str2num(extractAfter(parts{1}, ": "));
    rightNumbers(i, :) = str2num(parts{2});
end

%% Part 1
totval = 0;
for rows = 1:height(rightNumbers)
    val = 0;
    for cols = 1:width(rightNumbers)
         if  ismember(rightNumbers(rows, cols), leftNumbers(rows, :))
             if val == 0;
                 val = 1;
             else
                val = val*2;
             end
         end
    end
    totval = totval + val;
end
part1 = totval
%% Part 2 Solved at place 4976
numberArray = ones(height(rightNumbers),1);
for rows = 1:height(rightNumbers)
    val = 0;
    for cols = 1:width(rightNumbers)
         if  ismember(rightNumbers(rows, cols), leftNumbers(rows, :))
             val = val +1;
         end
    end
    numberArray(rows+1:rows+val,1) = numberArray(rows+1:rows+val,1) + numberArray(rows);
end

part2 = sum(numberArray)
