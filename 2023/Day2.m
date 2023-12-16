clear all
data = readlines("Input.txt");
data = cellfun(@(x) x(strfind(x, ':') + 2:end), data, 'UniformOutput', false);
for i = 1:height(data)
    splitData{i,1}  = strsplit(data{i,:},';');
end
%% Part 1
validGames = 0;
for i = 1:height(splitData)
    flagga = true;
    for j = 1:width(splitData{i})
        green = 13;
        blue = 14;
        red = 12;
        round = string(strsplit(splitData{i}{j},","));
        for k = 1:width(round)
            roundNumber = double(regexp(string(round(k)),"[0-9]+","match"));
            if ~isempty(regexp(string(round(k)),"green"))
                green = green - roundNumber;
            elseif ~isempty(regexp(string(round(k)),"red"))
                red = red - roundNumber;
            elseif ~isempty(regexp(string(round(k)),"blue"))
                blue = blue - roundNumber;
            end
        end
        if any([blue<0, green<0, red<0])
            flagga = false;
        end
    end
    if flagga == true
        validGames = validGames + i;
    end
end
part1 = validGames
%% Part 2
power = 0;
sumPower = 0;
for i = 1:height(splitData)
    green = 0;
    blue = 0;
    red = 0;
    for j = 1:width(splitData{i})
        round = string(strsplit(splitData{i}{j},","));
        for k = 1:width(round)
            roundNumber = double(regexp(string(round(k)),"[0-9]+","match"));
            if ~isempty(regexp(string(round(k)),"green"))
                green = max(green,roundNumber);
            elseif ~isempty(regexp(string(round(k)),"red"))
                red = max(red,roundNumber);
            elseif ~isempty(regexp(string(round(k)),"blue"))
                blue = max(blue,roundNumber);
            end
        end
    end
    sumPower = sumPower + green*red*blue;
end
part2 = sumPower
