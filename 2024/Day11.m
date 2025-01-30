clear all;
% Read the input file
% Read the file
data = readlines("Input.txt");

newData = strsplit(data)

for i = 1:length(newData)
    stones(i) = str2num(newData(i))
end


%%

for j = 1:75
    j
    tic
    i = 1;
    zeroIndices = find(stones == 0);
    digitCounts = floor(log10(abs(stones))) + 1; % Calculate digit count for each stone
    digitCounts(stones == 0) = 0; % Replace -Inf for zeros with 0
    nonZeroIndices = find(stones ~= 0); % Exclude zeros
    even = intersect(find(~mod(digitCounts, 2)), nonZeroIndices); % Indices with even digits and non-zero
    odd = intersect(find(mod(digitCounts, 2)), nonZeroIndices); % Indices with odd digits and non-zero
    
    stones(zeroIndices) = 1;

    stones(odd) = stones(odd) * 2024;
    if ~isempty(even)
    for idx = flip(even)
            splitPoint = (floor(log10(abs(stones(idx)))) + 1)/2;
            numStr = num2str(stones(idx));
            firstHalf = numStr(1:splitPoint);
            secondHalf = numStr(splitPoint+1:end);
            stones(idx) = str2num(firstHalf);
            stones(end+1) = str2num(secondHalf);
    end
    end
    toc
end

length(stones)

