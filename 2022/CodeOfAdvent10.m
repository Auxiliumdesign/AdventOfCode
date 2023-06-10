clear all
S = readmatrix('10_1.csv')
S = [S(23:25,:); S(1:end,:)]
%% Part 1 and 2
cycle = 0;
x = 1;
signalStrength  = 0;
CRTMatrix = zeros(40,6)
for i = 1:length(S)
    compcycle = mod(cycle,40);
    if ~isnan(S(i,2))
        cycle = cycle+1;
        compcycle = compcycle +1;
        if x-compcycle+1<=1 && x-compcycle+1>=-1
            CRTMatrix(cycle) = 9;
        end
        if mod(cycle+20,40) == 0
            signalStrength = signalStrength + cycle*x;
        end
        cycle = cycle+1;
        compcycle = compcycle +1;
        if x-compcycle+1<=1 && x-compcycle+1>=-1
            CRTMatrix(cycle) = 9;
        end
        if mod(cycle+20,40) == 0
            signalStrength = signalStrength + cycle*x;
        end
        x = x+S(i,2);
    else
        cycle = cycle+1;
        compcycle = compcycle +1;
        if x-compcycle+1<=1 && x-compcycle+1>=-1
            CRTMatrix(cycle) = 9;
        end
        if mod(cycle+20,40) == 0
            signalStrength = signalStrength + cycle*x;

        end

    end
end
part1 = signalStrength
imshow(transpose(CRTMatrix))