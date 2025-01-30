clear all;
data = readlines("Input.txt");
pattern ='mul\((\d+),(\d+)\)';
[matches, startIdx] = regexp(data, pattern, 'tokens');
part1 = 0
for i = 1:height(matches)
    for j = 1:length(matches{i})
        part1  = part1 + double(matches{i}{j}(1))*double(matches{i}{j}(2))
    end
end

%%

[matchesDo, startIdxDo] = regexp(data, 'do\(\)', 'tokens');
[matchesDont, startIdxDont] = regexp(data, 'don''t\(\)', 'match', 'start');
part2 = 0
for i = 1:height(matches)
for j = 1:length(matches{i})
    currentidX = startIdx{i}(j)
    latestDo = startIdxDo{i}(max(find(startIdxDo{i} < currentidX)))
    latestDont = startIdxDont{i}(max(find(startIdxDont{i} < currentidX)))
    if any([latestDo > latestDont, (isempty(latestDont)&&carryDo)])
       part2  = part2 + double(matches{i}{j}(1))*double(matches{i}{j}(2))
    end
end
    carryDo =  max(startIdxDo{i})>max(startIdxDont{i})
end
