clear all
%There are four cycles in part 2, which all happen before 5000 runs, for
%part 2 answer, run with rounds 5000
rounds = 1000
data = readlines("Inputb.txt")
part2 = 1
for i = 1:height(data)
    inputStr = char(data(i))
    arrowIndex = strfind(inputStr, '->');
    beforeArrow = strtrim(inputStr(1:arrowIndex-1));
    afterArrow = strtrim(inputStr(arrowIndex+2:end));
    type = 1 + strcmp(beforeArrow(1), '&'); % 1 for %, 2 for &
    moduleName = strtrim(beforeArrow(2:end));
    outputs = strsplit(afterArrow, ', ');
    dataArray(i,:) = [type, moduleName, {outputs}];
end

broadNr = find(strcmp(dataArray(:,2),{'roadcaster'}))
dataArray{broadNr,1} = 0
dataArray{broadNr,2} ='broadcaster'
inputs = dataArray(:,2)
inputs(:, 2) = cell(height(data), 1);

for i = 1:height(dataArray)
    inside = dataArray{i,3}
    for k = 1:length(inside)
        foundNr = find(strcmp(dataArray(:,2),inside{k}))
        if ~isempty(foundNr)
            if isempty(inputs{foundNr,2})
                inputs{foundNr,2} = dataArray{i,2}
            else
                inputs{foundNr,2} = [inputs{foundNr,2}, {dataArray{i,2}}];
            end
        end
    end
end

for i = 1:size(dataArray, 1)
    dataArray{i, 4} = 0;
end

pulses = [0,0];
for round = 1:rounds
    pulses(1) = pulses(1) + 1;
    queue = ["broadcaster"];
    queuePulse = [0];
    while ~isempty(queue)
        index = find(strcmp(dataArray(:,2),{char(queue(1))}));
        if ~isempty(index)
            outputs = dataArray{index,3};
            if dataArray{index,1} == 2
                allHigh = true;
                input = inputs{index,2};
                if iscell(input)
                    for k = 1:length(input)
                        inIndex  = find(strcmp(dataArray(:,2),{char(input(k))}));
                        if dataArray{inIndex,4} ~= 1
                            allHigh = false;
                            break
                        end
                    end
                else
                    inIndex  = find(strcmp(dataArray(:,2),{char(input(1,:))}));
                    if dataArray{inIndex,4} ~= 1
                        allHigh = false;
                    end
                end
                for k = 1:length(outputs)
                    queue = [queue,outputs{k}];
                    queuePulse = [queuePulse, ~allHigh];
                    pulses(~allHigh+1) = pulses(~allHigh+1) + 1;
                end
                dataArray{index,4} = ~allHigh;
                if all([outputs{k} == 'tj',~allHigh == 1])
                    part2 = part2*round
                end
            elseif dataArray{index,1} == 1
                if queuePulse(1) == 0
                    signal = ~dataArray{index,4};
                    for k = 1:length(outputs)
                        queue = [queue,outputs{k}];
                        queuePulse = [queuePulse, signal];
                        pulses(signal+1) = pulses(signal+1) + 1;
                    end
                    dataArray{index,4} = signal;
                end
            elseif dataArray{index,1} == 0
                for k = 1:length(outputs)
                    queue = [queue,outputs{k}];
                    queuePulse = [queuePulse, 0];
                    pulses(1) = pulses(1) + 1;
                end
            end
        end
        queue = queue(2:end);
        queuePulse = queuePulse(2:end);
    end
end
part1 = pulses(1)*pulses(2)
part2