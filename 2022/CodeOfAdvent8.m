clear all
format long
S = readlines('8_1.csv');
VA = cellfun(@(x) double(x) - '0', cellstr(S), 'UniformOutput', false);
VA = cell2mat(VA);
%% Part 1
visibleCounter = 0;
for i = 2:height(VA)-1
    for j = 2:width(VA)-1
        value = VA(i,j);
        if value > max(VA(i,1:j-1)) || value > max(VA(i,j+1:end)) || value > max(VA(1:i-1,j)) || value > max(VA(i+1:end,j))
            visibleCounter = visibleCounter +1;
        end
    end
end
visibleCounter = visibleCounter + 2*width(VA) + 2*height(VA) -4;
part1 = visibleCounter

%% part 2
ScenicScore = ones(height(VA),width(VA));
for i = 1:height(VA)
    for j = 1:width(VA)
        value = VA(i,j);
        currj = j;
        currcount = 0;
        while currj>1
            if VA(i,currj-1)<value
                currcount = currcount+1;
                currj=currj-1;
            else
                currcount = currcount+1;
                break
            end
        end
        ScenicScore(i,j) = ScenicScore(i,j)*currcount;
        currj = j;
        currcount = 0;
        while currj<width(VA)
            if VA(i,currj+1)<value
                currcount = currcount+1;
                currj=currj+1;
            else
                currcount = currcount+1;
                break
            end
        end
        ScenicScore(i,j) = ScenicScore(i,j)*currcount;
        curri = i;
        currcount = 0;
        while curri<height(VA)
            if VA(curri+1,j)<value
                currcount = currcount+1;
                curri=curri+1;
            else
                currcount = currcount+1;
                break
            end
        end
        ScenicScore(i,j) = ScenicScore(i,j)*currcount;
        curri = i;
        currcount = 0;
        while curri>1
            if VA(curri-1,j)<value
                currcount = currcount+1;
                curri=curri-1;
            else
                currcount = currcount+1;
                break
            end
        end
        ScenicScore(i,j) = ScenicScore(i,j)*currcount;
        
    end
end
part2 = max(max(ScenicScore))
