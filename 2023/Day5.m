parsedData = parseUpdatedStrings(readlines("Input.txt"));
data = readlines("Input.txt")
seeds = double(strsplit(data(1)))
%% Part 1
for k = 1:length(seeds)
    fields = fieldnames(parsedData);
    valueToFind = seeds(k);
        for i = 1:numel(fields)
            fieldName = fields{i};
            fieldValue = parsedData.(fieldName);
            counter = 1;
            seedRangeFound  = false;
            while ~seedRangeFound && counter <= height(fieldValue)
                seedRangeFound = isNumberBetween(valueToFind,fieldValue(counter,2),fieldValue(counter,2)+fieldValue(counter,3));
                if seedRangeFound
                    valueToFind = valueToFind + (fieldValue(counter,1)-fieldValue(counter,2));
                end
                counter = counter +1;
            end
        end
        endValue(k) = valueToFind;
end
part1 = min(endValue)

%% Part 2
fields = fieldnames(parsedData);
currNumRange = [seeds(1,1:2:end)',seeds(1,2:2:end)'];
for i = 1:numel(fields)
    newNumRange = [];
    fieldName = fields{i};
    fieldValue = parsedData.(fieldName);
    for j = 1:height(parsedData.(fieldName))
        startOfDestRange = parsedData.(fieldName)(j,1);
        startOfSourceRange = parsedData.(fieldName)(j,2);
        endOfSourceRange = parsedData.(fieldName)(j,2)+parsedData.(fieldName)(j,3);
        "Checking Range " + j + " in " + fieldName;
        diff = startOfDestRange - startOfSourceRange;
        for k = 1:height(currNumRange)
            if isNumberBetween(currNumRange(k,1), startOfSourceRange, endOfSourceRange) && isNumberBetween(currNumRange(k,1)+currNumRange(k,2)-1, startOfSourceRange, endOfSourceRange)
                newNumRange = [newNumRange; currNumRange(k,1) + diff , currNumRange(k,2)];
                currNumRange(k,1) = 0;
                currNumRange(k,2) = 0;
            elseif isNumberBetween(startOfSourceRange,currNumRange(k,1), currNumRange(k,1)+currNumRange(k,2)) && isNumberBetween(endOfSourceRange,currNumRange(k,1), currNumRange(k,1)+currNumRange(k,2))
                newNumRange = [newNumRange; startOfSourceRange + diff , endOfSourceRange-startOfSourceRange];
                currNumRange(end+1,1) = endOfSourceRange;
                currNumRange(end+1,2) = currNumRange(k,1) +  currNumRange(k,2) - endOfSourceRange;
                currNumRange(k,1) = currNumRange(k,1);
                currNumRange(k,2) = startOfSourceRange - currNumRange(k,1);

            elseif isNumberBetween(currNumRange(k,1), startOfSourceRange, endOfSourceRange)
                newNumRange = [newNumRange; currNumRange(k,1) + diff , endOfSourceRange-currNumRange(k,1)];
                currNumRange(k,2) = currNumRange(k,1)+currNumRange(k,2) - endOfSourceRange;
                currNumRange(k,1) = endOfSourceRange;
             %End of range is within the source range
            elseif isNumberBetween(currNumRange(k,1)+currNumRange(k,2)-1, startOfSourceRange, endOfSourceRange)
                newNumRange = [newNumRange; startOfSourceRange + diff , currNumRange(k,1)+currNumRange(k,2)-startOfSourceRange];
                currNumRange(k,2) = startOfSourceRange - currNumRange(k,1);
                currNumRange(k,1) = currNumRange(k,1);
            end
        end
    end
    currNumRange = currNumRange(all(currNumRange,2),:);
    newNumRange = [newNumRange;currNumRange];
    currNumRange = newNumRange;
end

finalRanges = currNumRange(all(currNumRange > 0, 2), :);
part2 = min(finalRanges(:,1))
toc


function isBetween = isNumberBetween(num, lowerBound, upperBound)
    isBetween = (num >= lowerBound) && (num <= upperBound);
end

function parsedData = parseUpdatedStrings(inputString)
    lines = splitlines(inputString);
    currentKey = '';
    currentValue = [];
    for i = 1:length(lines)
        line = lines{i};
        if endsWith(line, 'map:')
            if ~isempty(currentKey)
                parsedData.(currentKey) = currentValue;
            end

            currentKey = extractBefore(line, ':');
            currentKey = strrep(currentKey, '-', '_');
            currentKey = strrep(currentKey, ' ', '_');
            currentValue = [];
        else
            nums = sscanf(line, '%f %f %f', [1, 3]);
            currentValue = [currentValue; nums];
        end
    end
    if ~isempty(currentKey)
        parsedData.(currentKey) = currentValue;
    end
end




