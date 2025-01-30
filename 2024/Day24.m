clear all;
data = readlines("Input.txt");
init = readlines("Initial.txt");
% Preallocate a structure to store results
operations = struct('input1', {}, 'operand', {}, 'input2', {}, 'output', {});

% Define a mapping from operand strings to numerical values
operandMap = containers.Map({'OR', 'XOR', 'AND'}, [1, 2, 3]);

% Loop through each line of input
for i = 1:length(data)
    line = data{i};

    % Use a regular expression to parse the line
    pattern = '^(\w+)\s+(XOR|AND|OR)\s+(\w+)\s+->\s+(\w+)$';
    tokens = regexp(line, pattern, 'tokens');

    % Check if the line matches the expected format
    if ~isempty(tokens)
        tokens = tokens{1}; % Extract the matched tokens

        % Store the parsed components in the structure
        operations(i).input1 = tokens{1};
        operations(i).operand = operandMap(tokens{2}); % Map operand to numerical value
        operations(i).input2 = tokens{3};
        operations(i).output = tokens{4};
    else
        error('Line %d does not match the expected format.', i);
    end
end

% Define the pairs of outputs to swap
swapPairs = {
    'vcg', 'z24';
    'rkf', 'z20';
    'jgb', 'z09';
    'rvc','rrs'
};

% Loop through each pair and perform the swap
for i = 1:size(swapPairs, 1)
    output1 = swapPairs{i, 1};
    output2 = swapPairs{i, 2};
    
    % Find the indices of the outputs to swap
    index1 = find(strcmp({operations.output}, output1));
    index2 = find(strcmp({operations.output}, output2));
    
    % Check if both outputs are found
    if ~isempty(index1) && ~isempty(index2)
        % Swap the outputs
        temp = operations(index1).output;
        operations(index1).output = operations(index2).output;
        operations(index2).output = temp;
        disp(['Swapped "' output1 '" with "' output2 '".']);
    else
        disp(['One or both outputs not found for pair: "' output1 '", "' output2 '".']);
    end
end


%
% Initialize the key-value map with default -1 for not assigned
% Collect all unique labels (inputs and outputs)
labels = {};
for i = 1:length(operations)
    labels = [labels, operations(i).input1, operations(i).input2, operations(i).output]; %#ok<AGROW>
end
labels = unique(labels);
truthMap = containers.Map(labels, repmat({-1000}, size(labels)));

for i = 1:height(init)
    parts = strsplit(init(i));
    partsLabel = strsplit(parts(1),':');
    partsLabel = partsLabel(1);
    value = str2double(parts(2));
    truthMap(partsLabel) = value;
end


% Display the key-value map
disp('Key-Value Map (Label -> Status):');
keys = truthMap.keys;
for i = 1:length(keys)
    fprintf('%s -> %d\n', keys{i}, truthMap(keys{i}));
end

%
tic
PrevValues = {1};
values = {2};
while ~isequal(PrevValues, values)
    PrevValues = values;
for i = 1:length(operations)
 if truthMap(operations(i).input1) ~= -1000 || truthMap(operations(i).input2) ~= -1000
 switch operations(i).operand
        case 1  % OR
             truthMap(operations(i).output) = or(truthMap(operations(i).input1),truthMap(operations(i).input2));
        case 2  % XOR
           truthMap(operations(i).output) = xor(truthMap(operations(i).input1),truthMap(operations(i).input2));
        case 3  % AND
            truthMap(operations(i).output) = and(truthMap(operations(i).input1),truthMap(operations(i).input2));
 end
 end
end
values = truthMap.values;
end
toc

%
% Get all keys and values
% Get all keys and values
keys = truthMap.keys;      % Cell array of keys
values = truthMap.values;  % Cell array of values

% Combine keys and values into a cell array
truthCellArray = [keys(:), values(:)]; % Convert both to column vectors and concatenate

% % Display the cell array
% disp('TruthMap as Cell Array:');
% disp(truthCellArray);


truthMap('z00')

% Extract values for keys z00 to z12
binaryValues = [];
for i = 45:-1:0
    key = sprintf('z%02d', i); % Create key (z00, z01, ..., z12)
    binaryValues = [binaryValues, truthMap(key)]; % Append value to binary array
end

% Convert binary array to a binary string
binaryString = num2str(binaryValues); % Convert numeric array to string with spaces
binaryString = strrep(binaryString, ' ', ''); % Remove spaces to concatenate

% Convert binary string to decimal
decimalValue = bin2dec(binaryString);

% Display the result
fprintf('The concatenated binary string is: %s\n', binaryString);
fprintf('The decimal equivalent is: %d\n', decimalValue);

dec2bin(bitxor(45920934306510,decimalValue))


%%
for i = 1:44
    if i < 10
    xS = "x0"+num2str(i)
    yS = "y0"+num2str(i)
    else
    xS = "x"+num2str(i)
    yS = "y"+num2str(i)
    end
    result = operations(arrayfun(@(x) contains(x.input1, char(xS)), operations));
    result2 = operations(arrayfun(@(x) contains(x.input1, char(yS)), operations));

    if length(result) + length(result2) ~= 2
        "here"
    end
    if sum([result.operand]) + sum([result2.operand]) ~= 5
        "here"
    end
    for j = 1:length(result2)
        %AND
        if result2(j).operand == 3
              resultFirst = operations(arrayfun(@(x) contains(x.input1, result2(j).output), operations));
              resultSecond = operations(arrayfun(@(x) contains(x.input2, result2(j).output), operations));
               if sum([resultFirst.operand]) + sum([resultSecond.operand]) ~= 1
                    "here"
               end
               if isempty(resultFirst)
                 resultFirst2 = operations(arrayfun(@(x) contains(x.input1, resultSecond.output), operations));
                 resultSecond2 = operations(arrayfun(@(x) contains(x.input2, resultSecond.output), operations));
                  
               else
                 resultFirst2 = operations(arrayfun(@(x) contains(x.input1, resultFirst.output), operations));
                 resultSecond2 = operations(arrayfun(@(x) contains(x.input2, resultFirst.output), operations));
                 
               end

               
               
        end
    end
end

%%


%%


%%
% Initialize arrays to store edges
sources = {};
destinations = {};

% Build the edge list from operations
for i = 1:length(operations)
    sources = [sources, operations(i).input1, operations(i).input2]; %#ok<AGROW>
    destinations = [destinations, operations(i).output, operations(i).output]; %#ok<AGROW>
end

% Create a directed graph
G = digraph(sources, destinations);

% Identify all paths leading to 'z00'
targetNode = 'z45';
highlightPaths = {}; % Cell array to store paths

% Traverse all nodes to find paths leading to 'z00'
allNodes = G.Nodes.Name; % Get all node names
for i = 1:numel(allNodes)
    startNode = allNodes{i};
    % Check if both nodes exist in the graph
    if ismember(startNode, allNodes) && ismember(targetNode, allNodes)
        path = shortestpath(G, startNode, targetNode); % Get path
        if ~isempty(path) % If a path exists, store it
            highlightPaths{end + 1} = path; %#ok<AGROW>
        end
    end
end
sourceNodes = {};
for i = 0:44
    sourceNodes{end+1} = sprintf('x%02d', i); %#ok<AGROW>
    sourceNodes{end+1} = sprintf('y%02d', i); %#ok<AGROW>
end
sinkNodes = {};
for i = 0:45
    sinkNodes{end+1} = sprintf('z%02d', i); %#ok<AGROW>
end
% Highlight the paths in the graph
figure;
p = plot(G, 'Layout', 'layered','sources',sourceNodes,'sinks',sinkNodes, 'ArrowSize', 10);

% Highlight edges leading to 'z00'
for i = 1:numel(highlightPaths)
    path = highlightPaths{i};
    highlight(p, path, 'EdgeColor', 'r', 'LineWidth', 2); % Highlight the path
end

title('Directed Node Graph with Highlighted Paths to z00');
xlabel('Nodes');
ylabel('Connections');

%%



bin2dec('101011011001000001101101010111101111010101111') + bin2dec('101000001000110111111010011100100010000011111')