clear all;
data = readlines("Input.txt");
rules = zeros(100, 100); % Pre-allocate a 100x100 matrix (adjust size as needed)
for i  = 1:height(data)
    split = strsplit(data(i),"|");
    firstnum = double(split(1));
    secondnum = double(split(2));
    rules(firstnum,secondnum) = 1;
end


%%
data = readlines("Rules.txt");
sum = 0;
for i = 1:height(data)
    updateDouble = double(strsplit(data(i),","));
    flag = true;
    for j = 1:length(updateDouble)
        allowedBefore = transpose(find(rules(:,updateDouble(j))))
        if any(ismember(updateDouble(j+1:end),allowedBefore))
            flag = false;
            break
        end
    end
    if flag
        sum = sum + updateDouble(round(length(updateDouble)/2));
    end
end

%% part 2
tic
data = readlines("Rules.txt");
sum = 0;
update = strsplit(data(i),",");
for i = 1:height(data)
    updateDouble = double(strsplit(data(i),","));
    flag = true;
    for j = 1:length(updateDouble)
        allowedBefore = transpose(find(rules(:,updateDouble(j))));
        if any(ismember(updateDouble(j+1:end),allowedBefore))
            flag = false;
            break
        end
    end
    if flag
        continue
    end
    while ~flag
        flag = true;
        for j = 1:length(updateDouble)
            allowedBefore = transpose(find(rules(:,updateDouble(j))));
            if j < length(updateDouble)
                if any(ismember(updateDouble(j+1:end),allowedBefore))
                    finds = find(ismember(updateDouble, allowedBefore));
                    otherNums = setdiff(updateDouble,[updateDouble(finds), updateDouble(j)],'stable');
                    newOrder = [updateDouble(finds), updateDouble(j),otherNums] ;
                    break
                end
            end
        end
        updateDouble = newOrder;
        for j = 1:length(updateDouble)
            allowedBefore = transpose(find(rules(:,updateDouble(j))));
            if any(ismember(updateDouble(j+1:end),allowedBefore))
                flag = false;
                break
            end
        end
    end
    sum = sum + updateDouble(round(length(updateDouble)/2));
end

toc