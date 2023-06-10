clear all
S = readlines('4_1.csv');
ValueStrings = split(split(S,','),'-');
%% part 1 and 2
part1 = 0
part2 = 0
for i = 1:length(ValueStrings) 
    RH=str2num(ValueStrings(i,2,2));
    RL=str2num(ValueStrings(i,2,1));
    LH=str2num(ValueStrings(i,1,2));
    LL=str2num(ValueStrings(i,1,1));
    if (RL<=LL && LH<=RH) || (RL>=LL && LH>=RH)
        part1=part1+1;
    end
    if (LL<=RL && LH>=RL)  || (RL<=LL && LL<=RH)
        part2 = part2+1;
    end
end
part1
part2
