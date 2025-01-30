clear all;
towels = readlines("Input.txt");
patterns = readlines("Test.txt");

tow = strsplit(towels,",")
tow = strtrim(tow)


%Nuvarande position

count = 0;
for j = 1:height(patterns)
    queue = [1]
    while ~isempty(queue)
         tempQueue = []
         tempStrings = []
    for k = 1:width(queue)
        for i = 1:width(tow)
            A = strfind(patterns(j),tow(i));
            if any(A==queue(k)) && strlength(tow(i)) + queue(k)<= strlength(patterns(j))
                tempQueue = [tempQueue,queue(k) + strlength(tow(i))];
                tempStrings = [tempStrings,tow(i)]
            end
        end
    end
    if any(tempQueue==strlength(patterns(j)))
        count = count + 1;
    end
    queue = tempQueue;
    end
end


%%

clear all;
towels = readlines("Input.txt");
patterns = readlines("Test.txt");

tow = strsplit(towels,",")
tow = strtrim(tow)


%Nuvarande position

count = 0;
tic
parfor j = 1:height(patterns)
    queue = [1]
    while ~isempty(queue)
         tempQueue = []
    for k = 1:width(queue)
        for i = 1:width(tow)
            A = strfind(patterns(j),tow(i));
            if any(A==queue(k)) && strlength(tow(i)) + queue(k)<= strlength(patterns(j))
                tempQueue = [queue(k) + strlength(tow(i)),tempQueue];
            end
        end
    end
    if any(tempQueue==strlength(patterns(j)))
        count = count + 1;
        break
    end
    tempQueue = unique(tempQueue);
    queue = tempQueue;
    end
end
toc

%% DFS attempt

clear all;
towels = readlines("Input.txt");
patterns = readlines("Test.txt");

tow = strsplit(towels,",")
tow = strtrim(tow)

count = 0
%Nuvarande position
tic
for j = 1:height(patterns)
    stack = [1];
    patterns(j)
    while ~isempty(stack)
         v = stack(end);
         stack(end) = [];
        for i = 1:width(tow)
            A = strfind(patterns(j),tow(i));
            if any(A==v) && strlength(tow(i)) + v <= strlength(patterns(j))+1;
                stack(end + 1) = v + strlength(tow(i));
            end
        end
    if v==strlength(patterns(j))+1
        count = count + 1;
    end

    end
end
toc

%%