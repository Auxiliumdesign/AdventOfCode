clear all
data = readlines("Test.txt");
part2 = true
for i = 1:length(data)
     directions(i,1) = regexp(data(i), '[RDLU]', 'match', 'once');
     numbers(i,1) = str2double(regexp(data(i), '\d+', 'match', 'once'));
     colors(i,1) = regexp(data(i), '[0-9a-fA-F]{6}', 'match', 'once');
end
if part2
    colors = char(colors);
    for i = 1:height(colors)
        numbers(i,1) = hex2dec(colors(i,1:end-1));
        switch colors(i,end)
            case '0'
                directions(i,1) = 'R';
            case '1'
                directions(i,1) = 'D';
            case '2'
                directions(i,1) = 'L';
            case'3'
                directions(i,1) = 'U';
        end
    end
end

currentPos = [0,0];
rows = [0];
cols = [0];

for i = 1:height(data)
    switch directions(i)
        case 'U'
           rows = [rows, currentPos(1)-numbers(i)];
           cols = [cols,currentPos(2)];
           currentPos(1) = currentPos(1) - numbers(i);
        case 'D'
           rows = [rows, currentPos(1)+numbers(i)];
           cols = [cols,currentPos(2)];
           currentPos(1) = currentPos(1) + numbers(i);
        case 'R'
           rows = [rows, currentPos(1)];
           cols = [cols,currentPos(2)+numbers(i)];
           currentPos(2) = currentPos(2) + numbers(i);
        case 'L'
           rows = [rows, currentPos(1)];
           cols = [cols,currentPos(2)-numbers(i)];
           currentPos(2) = currentPos(2) - numbers(i);
    end
end

P = polyshape(rows,cols);
answer = area(P)+(perimeter(P)/2)+1