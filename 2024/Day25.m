clear all;
data = readlines("Input.txt");
counter = 0;
for i = 1:8:height(data)
    currLockKey = char(data(i:i+6));
    for j = i:8:height(data)
           if ~any(any(currLockKey + char(data(j:j+6)) < 81))
            counter = counter +1;
           end
    end
end
