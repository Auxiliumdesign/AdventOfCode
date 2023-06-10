clear all
format long
S = readlines('C:\Users\Hiraeth\Documents\MATLAB\CodeOfAdvent\12_1.csv');
c = char(S);
D=double(c);
D(find(c=='S')) = double('a');
D(find(c=='E')) = double('z');
%% Part 1
sz = [height(D),width(D)];
SpMat = zeros(height(D)*width(D),height(D)*width(D));
for i = 1:width(D)
    for j = 1:height(D)
        if j>1
            if D(j-1,i) <= D(j,i) + 1
                a = sub2ind(sz,j,i);
                b = sub2ind(sz,j-1,i);
                SpMat(a,b) = 1;
            end
        end
        if j<height(D)
            if D(j+1,i) <= D(j,i) + 1
                a = sub2ind(sz,j,i);
                b = sub2ind(sz,j+1,i);
                SpMat(a,b) = 1;
            end
        end
        if i<width(D)
            if D(j,i+1) <= D(j,i) + 1
                a = sub2ind(sz,j,i);
                b = sub2ind(sz,j,i+1);
                SpMat(a,b) = 1;
            end
        end
        if i>1
            if D(j,i-1) <= D(j,i) + 1
                a = sub2ind(sz,j,i);
                b = sub2ind(sz,j,i-1);
                SpMat(a,b) = 1;
            end
        end
    end
end

%%
G = digraph(SpMat);
[path1,d] =shortestpath(G,find(c=='S'),find(c=='E'));
part1 = d
%% Part 2
for i = 1:height(S)
    [~,d(i)] =shortestpath(G,i,find(c=='E'));
end
part2 = min(d)

%Nice graph
p = plot(G,'NodeColor','r');
highlight(p,path1,'LineWidth',2)
highlight(p,path1,'EdgeColor','g')
