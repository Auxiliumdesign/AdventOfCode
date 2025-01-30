clear all;
data = readlines("Test.txt");

%% Preallocate matrices and constants
nSteps = 2000;
nData = height(data);
price = zeros(nSteps + 1, nData);
change = zeros(nSteps, nData);

% Function for the next secret value
nextSecret = @(secret) bitand(bitxor(bitand(bitxor(secret * 64, secret), 16777215) * 2048, ...
                       bitand(bitxor(secret * 64, secret), 16777215)), 16777215);

% Precompute prices and changes
part1 = 0;
tic;
for i = 1:nData
    currNr = str2double(data(i));
    price(1, i) = mod(currNr, 10);
    for k = 1:nSteps
        currNr = nextSecret(currNr);
        price(k + 1, i) = mod(currNr, 10);
        change(k, i) = price(k + 1, i) - price(k, i);
    end
    part1 = part1 + currNr;
end
toc;

%% Extract unique sequences and associated prices
globalSeq = cell(nData, 2);
tic;
for k = 1:nData
    uniqueSeq = zeros(nSteps - 2, 4); % Preallocate for 4-sequence
    valueSeq = zeros(nSteps - 2, 1);

    % Extract sequences and values
    uniqueSeq = [change(1:end-3, k), change(2:end-2, k), change(3:end-1, k), change(4:end, k)];
    valueSeq = price(5:end, k);

    % Find unique sequences
    [C, ia] = unique(uniqueSeq, "rows", "stable");
    globalSeq{k, 1} = C;
    globalSeq{k, 2} = valueSeq(ia);
end
toc;

%% Consolidate global sequences
globalTot = zeros(0, 5); % Columns: seq(1:4) + totalPrice(5)
tic;
for i = 1:nData
    currSeq = globalSeq{i, 1};
    currPric = globalSeq{i, 2};

    for j = 1:size(currSeq, 1)
        currSeqRow = currSeq(j, :);
        currPricRow = currPric(j);

        % Check if the sequence exists in globalTot
        [Lia, Locb] = ismember(currSeqRow, globalTot(:, 1:4), "rows");
        if ~Lia
            % Add new sequence
            globalTot(end + 1, 1:4) = currSeqRow;
            globalTot(end, 5) = currPricRow;
        else
            % Update existing sequence
            globalTot(Locb, 5) = globalTot(Locb, 5) + currPricRow;
        end
    end
end
toc;

% Find maximum total price
maxPrice = max(globalTot(:, 5));
disp(maxPrice);
