clear all;
% Read the input file
data = readlines("Input.txt");
digits = char(data);
fullString = [];
 currentId = 0;
for i = 1:length(digits)
    if mod(i, 2) == 0
        dots = repmat(".", 1, str2double(digits(i)));
        fullString = [fullString dots];
    else
         dots = repmat(string(currentId), 1, str2double(digits(i)));
        fullString = [fullString dots];
         currentId = currentId +1;
    end
end
%%
indToMoveTo = 0;
indToMove = 1;
while indToMoveTo < indToMove
    indToMove = find(fullString~=".",1,"last");
    idToMove = fullString(indToMove);
    indToMoveTo = find(fullString==".",1,"first");
    if indToMoveTo < indToMove
    fullString(indToMoveTo) = idToMove;
    fullString(indToMove)= ".";
    end
end

%%
sum = 0;
for i = 1:find(fullString~=".",1,"last")
    sum = sum + str2double(fullString(i))*(i-1);
end