clear all
data = readlines("Input.txt");

%% Part 1
for i = 1:length(data)
dataInArray = strsplit(data(i));
data1(i) = sort(double(dataInArray(1)));
data2(i) = sort(double(dataInArray(2)));
end
part1 = sum(abs(data1-data2));

%% Part 2
sum = 0;
for i = 1:length(data1)
    pos = find(data1(i) == data2);
    sum = sum + data1(i)*length(pos);
end


