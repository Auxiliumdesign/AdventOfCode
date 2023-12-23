clear all
%% Data parsing
data =readlines("Input.txt");
data = char(data);
for i = 1:height(data)
    for j = 1:width(data)
        numbers(i,j) = str2num(data(i,j));
    end
end
data = numbers
%% Exhaustive search not optimized.
%Heading, down = 1, right = 2, up = 3, left = 4
stack=[1,1,1,0]
d = dictionary({[1,1,1,0]},0)
c = 0
tic
while ~isempty(stack)
    c =  c +1;
    currStack = stack(1,:);
    currVal = d({currStack});
    stack = stack(2:end,:);

    % gå nedåt
    if currStack(1)+1 <= height(data) && currStack(3) ~= 3
    if currStack(3) == 1
        if currStack(4)<3
            if isKey(d,{[currStack(1)+1,currStack(2),currStack(3),currStack(4)+1]})
                if d({[currStack(1)+1,currStack(2),currStack(3),currStack(4)+1]}) > (currVal + data(currStack(1)+1,currStack(2)))
                    d({[currStack(1)+1,currStack(2),currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1)+1,currStack(2));
                    stack = [stack;currStack(1)+1,currStack(2),currStack(3),currStack(4)+1];
                end
            else
                d({[currStack(1)+1,currStack(2),currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1)+1,currStack(2));
                stack = [stack;currStack(1)+1,currStack(2),currStack(3),currStack(4)+1];
            end
        end
    else
        if isKey(d,{[currStack(1)+1,currStack(2),1,1]})
            if d({[currStack(1)+1,currStack(2),1,1]}) > (currVal + data(currStack(1)+1,currStack(2)))
                d({[currStack(1)+1,currStack(2),1,1]}) = currVal + data(currStack(1)+1,currStack(2));
                stack = [stack;currStack(1)+1,currStack(2),1,1];
            end
        else
            d({[currStack(1)+1,currStack(2),1,1]}) = currVal + data(currStack(1)+1,currStack(2));
            stack = [stack;currStack(1)+1,currStack(2),1,1];
        end
    end
    end

    % gå höger
    if currStack(2)+1 <= width(data) && currStack(3) ~= 4
    if currStack(3) == 2
        if currStack(4)<3
            if isKey(d,{[currStack(1),currStack(2)+1,currStack(3),currStack(4)+1]})
                if d({[currStack(1),currStack(2)+1,currStack(3),currStack(4)+1]}) > (currVal + data(currStack(1),currStack(2)+1))
                    d({[currStack(1),currStack(2)+1,currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1),currStack(2)+1);
                    stack = [stack;currStack(1),currStack(2)+1,currStack(3),currStack(4)+1];
                end
            else
                d({[currStack(1),currStack(2)+1,currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1),currStack(2)+1);
                stack = [stack;currStack(1),currStack(2)+1,currStack(3),currStack(4)+1];
            end
        end
    else
        if isKey(d,{[currStack(1),currStack(2)+1,2,1]})
            if d({[currStack(1),currStack(2)+1,2,1]}) > (currVal + data(currStack(1),currStack(2)+1))
                d({[currStack(1),currStack(2)+1,2,1]}) = currVal + data(currStack(1),currStack(2)+1);
                stack = [stack;currStack(1),currStack(2)+1,2,1];
            end
        else
            d({[currStack(1),currStack(2)+1,2,1]}) = currVal + data(currStack(1),currStack(2)+1);
            stack = [stack;currStack(1),currStack(2)+1,2,1];
        end
    end
    end

    % gå vänster
    if currStack(2)-1 >= 1 && currStack(3) ~= 2
    if currStack(3) == 4
        if currStack(4)<3
            if isKey(d,{[currStack(1),currStack(2)-1,currStack(3),currStack(4)+1]})
                if d({[currStack(1),currStack(2)-1,currStack(3),currStack(4)+1]}) > (currVal + data(currStack(1),currStack(2)-1))
                    d({[currStack(1),currStack(2)-1,currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1),currStack(2)-1);
                    stack = [stack;currStack(1),currStack(2)-1,currStack(3),currStack(4)+1];
                end
            else
                d({[currStack(1),currStack(2)-1,currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1),currStack(2)-1);
                stack = [stack;currStack(1),currStack(2)-1,currStack(3),currStack(4)+1];
            end
        end
    else
        if isKey(d,{[currStack(1),currStack(2)-1,4,1]})
            if d({[currStack(1),currStack(2)-1,4,1]}) > (currVal + data(currStack(1),currStack(2)-1))
                d({[currStack(1),currStack(2)-1,4,1]}) = currVal + data(currStack(1),currStack(2)-1);
                stack = [stack;currStack(1),currStack(2)-1,4,1];
            end
        else
            d({[currStack(1),currStack(2)-1,4,1]}) = currVal + data(currStack(1),currStack(2)-1);
            stack = [stack;currStack(1),currStack(2)-1,4,1];
        end
    end
    end
    % gå uppåt
    if currStack(1)-1 >= 1 && currStack(3) ~= 1
    if currStack(3) == 3
        if currStack(4)<3
            if isKey(d,{[currStack(1)-1,currStack(2),currStack(3),currStack(4)+1]})
                if d({[currStack(1)-1,currStack(2),currStack(3),currStack(4)+1]}) > (currVal + data(currStack(1)-1,currStack(2)))
                    d({[currStack(1)-1,currStack(2),currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1)-1,currStack(2));
                    stack = [stack;currStack(1)-1,currStack(2),currStack(3),currStack(4)+1];
                end
            else
                d({[currStack(1)-1,currStack(2),currStack(3),currStack(4)+1]}) =  currVal + data(currStack(1)-1,currStack(2));
                stack = [stack;currStack(1)-1,currStack(2),currStack(3),currStack(4)+1];
            end
        end
    else
        if isKey(d,{[currStack(1)-1,currStack(2),3,1]})
            if d({[currStack(1)-1,currStack(2),3,1]}) > (currVal + data(currStack(1)-1,currStack(2)))
                d({[currStack(1)-1,currStack(2),3,1]}) = currVal + data(currStack(1)-1,currStack(2));
                stack = [stack;currStack(1)-1,currStack(2),3,1];
            end
        else
            d({[currStack(1)-1,currStack(2),3,1]}) = currVal + data(currStack(1)-1,currStack(2));
            stack = [stack;currStack(1)-1,currStack(2),3,1];
        end
    end
    end
end
toc

%%

mini = Inf;
for i = 1:4
    for j = 1:3
        if isKey(d,{[height(data),width(data),i,j]})
            mini = min([mini,d({[height(data),width(data),i,j]})]);
        end
    end
end
part2 = mini