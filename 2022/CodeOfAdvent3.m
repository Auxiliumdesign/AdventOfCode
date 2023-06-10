clear all
S = readlines('3_1.csv');
%% Part 1
a(1) = ""
dsum = 0;
for i= 1:length(S)
    b = S{i};
    q(i,1:length(b)) = double(b);
    a(i,3) = unique(b(1:strlength(S(i))));
    a(i,1) = unique(b(1:strlength(S(i))/2));
    a(i,2) = unique(b(strlength(S(i))/2+1:strlength(S(i))));
    
    asum=sum(double(convertStringsToChars(a(i,3))));
    bsum=sum(double(convertStringsToChars(a(i,2))));
    csum=sum(double(convertStringsToChars(a(i,1))));
    num_uppr = nnz(convertStringsToChars(a(i,3)) == upper(convertStringsToChars(a(i,3))));
    num_lwr = numel(convertStringsToChars(a(i,3))) - num_uppr;
    asum = asum-num_uppr*38-num_lwr*96;
    num_uppr = nnz(convertStringsToChars(a(i,2)) == upper(convertStringsToChars(a(i,2))));
    num_lwr = numel(convertStringsToChars(a(i,2))) - num_uppr;
    bsum = bsum -num_uppr*38-num_lwr*96;
    num_uppr = nnz(convertStringsToChars(a(i,1)) == upper(convertStringsToChars(a(i,1))));
    num_lwr = numel(convertStringsToChars(a(i,1))) - num_uppr;
    csum = csum-num_uppr*38-num_lwr*96;
    dsum = dsum + bsum+csum-asum;
end
part1 = dsum
%% super ugly solution for part 2
for i= 1:length(S)/3
    for e = 1:48
        if(~isempty(find(q(1+3*(i-1),:)==q(3+3*(i-1),e))))
        comp1 = mean(q(1+3*(i-1),find(q(1+3*(i-1),:)==q(3+3*(i-1),e))));
        else
        comp1 = 0;
        end
        if(~isempty(find(q(2+3*(i-1),:)==q(3+3*(i-1),e))))
        comp2 = mean(q(2+3*(i-1),find(q(2+3*(i-1),:)==q(3+3*(i-1),e))));
        else
        comp2 = 0;
        end
        if comp2 == comp1 & comp1 > 0
            break
        end
    end
    if comp1>90
    comp1= comp1-96;
    else
    comp1= comp1-38;
    end
    comptot(i) = comp1;
end
part2 = sum(comptot)