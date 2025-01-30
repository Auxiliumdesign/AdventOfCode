clear all;
% Read the input file
data = readlines("Input.txt");

% Initialize a structure to store parsed data
parsedData = struct();

% Process each line
for i = 1:length(data)
    % Split the line into key and values
    line = strtrim(data(i)); % Remove any leading/trailing whitespace
    parts = split(line, ':'); % Split at the colon

    % Extract the key (convert to a number for easier use)
    key(i) = str2double(strtrim(parts{1}));

    % Extract the values (convert to a numeric array)
    values{i,1} = str2num(strtrim(parts{2})); %#ok<ST2NM>


end

sum = 0;

for i = 1:height(values)
    valid = false;
    n = width(values{i})-1
    binaryPermutations = dec2bin(0:(2^n - 1)) - '0'; % Generate all permutations as a matrix
    for j = 1:height(binaryPermutations)
        currValue = values{i}(1);
        for k = 1:width(binaryPermutations)
            if binaryPermutations(j,k) == 0
                currValue = currValue + values{i}(k+1);
            else
                currValue = currValue * values{i}(k+1);
            end
        end
        if currValue == key(i) 
            valid = true;
            break
        end
    end
    if valid
        sum = sum + key(i);
    end
end
%% part 2
clear all;
data = readlines("Input.txt");

% Initialize a structure to store parsed data
parsedData = struct();

% Process each line
for i = 1:length(data)
    % Split the line into key and values
    line = strtrim(data(i)); % Remove any leading/trailing whitespace
    parts = split(line, ':'); % Split at the colon

    % Extract the key (convert to a number for easier use)
    key(i) = str2double(strtrim(parts{1}));

    % Extract the values (convert to a numeric array)
    values{i,1} = str2num(strtrim(parts{2})); %#ok<ST2NM>


end
m = 2; % Maximum value in each position (0 to m)
sum = 0;
tic
for i = 1:height(values)
    i
    valid = false;
    n = width(values{i})-1;
        % Create grids for all dimensions using ndgrid
        grids = cell(1, n); % Cell array to hold the grids
        [grids{:}] = ndgrid(0:m); % Generate n-dimensional grids
    
        % Combine all grids into a matrix of permutations
        binaryPermutations = cell2mat(cellfun(@(g) g(:), grids, 'UniformOutput', false));
    for j = 1:height(binaryPermutations)
        currValue = values{i}(1);
        for k = 1:width(binaryPermutations)
            if binaryPermutations(j,k) == 0
                currValue = currValue + values{i}(k+1);
            elseif binaryPermutations(j,k) == 1
                currValue = currValue * values{i}(k+1);
            else
                currValue = str2double([num2str(currValue), num2str(values{i}(k+1))]);
            end
        end
        if currValue == key(i) 
            valid = true;
            break
        end
    end
    if valid
        sum = sum + key(i);
    end
end
toc