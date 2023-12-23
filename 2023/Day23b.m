clear all
data = char(readlines("Input.txt"));
grid=zeros(height(data),width(data))
grid(find(data=='.' | data=='>' | data=='<' | data=='v')) = 1;
wG = width(grid)
hG = height(grid)
startSearch = sub2ind([hG,wG],1,2);
endSearch = sub2ind([hG,wG],hG,wG-1);
s = []
t = []
for row = 1:hG-1
    for col = 1:wG-1
        if grid(row,col) == 1
            indCurr = sub2ind([hG,wG],row,col);
            if grid(row+1,col) == 1
                indNeigh = sub2ind([hG,wG],row+1,col);
                s = [s,indCurr];
                t = [t,indNeigh];
            end
            if grid(row,col+1) == 1
                indNeigh = sub2ind([hG,wG],row,col+1);
                s = [s,indCurr];
                t = [t,indNeigh];
            end
        end
    end
end
g = graph(s,t)
path = allpaths(g,startSearch,endSearch,'MaxNumPaths',170000);
part2 = max(cellfun(@length, path))-1