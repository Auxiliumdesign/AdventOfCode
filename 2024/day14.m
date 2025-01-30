clear all;

data = readlines("Input.txt");
iterations = 100;
grid = zeros(103,101);
for i = 1:height(data)
    datanew = strsplit(data(i),' ');
    datanew2 = strsplit(datanew(1),',');
    datanew3 = strsplit(datanew2(1),'=');
    posCol(i) = str2double(datanew3(2))+1;
    posRow(i) = str2double(datanew2(2))+1;
    datanew2 = strsplit(datanew(2),',');
    datanew3 = strsplit(datanew2(1),'=');
    velCol(i) = str2double(datanew3(2));
    velRow(i) = str2double(datanew2(2));
end

for i = 1:height(data)
    finalPosRow = mod(posRow(i) + velRow(i)*iterations,height(grid));
    finalPosCol = mod(posCol(i) + velCol(i)*iterations,width(grid));
    if finalPosCol == 0
        finalPosCol = width(grid);
    end
   if finalPosRow == 0
        finalPosRow = height(grid);
   end
   grid(finalPosRow,finalPosCol) = grid(finalPosRow,finalPosCol)+1;
end

quad1= sum(sum(grid(1:floor(height(grid)/2),1:floor(width(grid)/2))));
quad2= sum(sum(grid(1+round(height(grid)/2):end,1+round(width(grid)/2):end)));
quad3= sum(sum(grid(1+round(height(grid)/2):end,1:floor(width(grid)/2))));
quad4= sum(sum(grid(1:floor(height(grid)/2),1+round(width(grid)/2):end)));

quad1*quad2*quad3*quad4;

%%

b = 200;
for iterations = 1:100000
    grid = zeros(103,101);
    for i = 1:height(data)
       finalPosRow = mod(posRow(i) + velRow(i)*iterations,height(grid));
    finalPosCol = mod(posCol(i) + velCol(i)*iterations,width(grid));
    if finalPosCol == 0
        finalPosCol = width(grid);
    end
   if finalPosRow == 0
        finalPosRow = height(grid);
   end
   grid(finalPosRow,finalPosCol) = grid(finalPosRow,finalPosCol)+1;
    end
    b = height(bwboundaries(grid));
    if b < 150
        break
    end
end