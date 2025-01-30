clear all;
data = readlines("Input.txt");

% Parse each line and convert it into numerical arrays
parsedData = cellfun(@(line) str2double(strsplit(line)), data, 'UniformOutput', false);

% Initialize the counter
counter = 0;

% Function to check safety and sorted conditions
isSafeAndSorted = @(nums) all(abs(diff(nums)) <= 3 & abs(diff(nums)) >= 1) && ...
                           (issorted(nums) || issorted(nums, 'descend'));

% Loop through each parsed data line
for i = 1:length(parsedData)
    numbersFull = parsedData{i};
    % Check if the current line is safe and sorted
    if isSafeAndSorted(numbersFull)
        counter = counter + 1;
    else
        % Test removing each element and rechecking
        for numtest = 1:length(numbersFull)
            reducedNums = numbersFull([1:numtest-1, numtest+1:end]);
            if isSafeAndSorted(reducedNums)
                counter = counter + 1;
                break; % No need to test further for this line
            end
        end
    end
end
