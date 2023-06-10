clear all
S = readlines('9_1.csv');
D = split(S);
part1 = calcRopeVisits(2,D)
part2 = calcRopeVisits(10,D)
%% part 1 and 2, not optimized
tic
function answer = calcRopeVisits(RopeLength,D)
RopeArea = 130;
H =zeros(RopeArea,RopeArea,RopeLength);
S =zeros(RopeArea,RopeArea);
H(RopeArea,RopeArea,:) = 1;
S(RopeArea,RopeArea) = 1;
for i = 1:length(D)
    for j = 1:double(D(i,2))
        [rowH,colH] = find(H(:,:,1));
        H(rowH,colH,1) = 0;
        if D(i,1) == "R"
            H(rowH,colH+1,1) = 1;
        elseif  D(i,1) == "L"
            H(rowH,colH-1,1) = 1;
        elseif  D(i,1) == "U"
            H(rowH+1,colH,1) = 1;
        elseif D(i,1) == "D"
            H(rowH-1,colH,1) = 1;
        end

        for l = 1:size(H,3)-1
            [rowH,colH] = find(H(:,:,l));
            [rowHn,colHn]  = find(H(:,:,l+1));
            HTDist = pdist([rowH, colH; rowHn, colHn],'euclidean');
            YDist = rowH-rowHn;
            XDist = colH-colHn;
            if HTDist>=2
                H(rowHn,colHn,l+1) =0;
                if YDist == 0
                    H(rowHn,colHn+XDist/abs(XDist),l+1) =1;
                elseif XDist == 0
                    H(rowHn+YDist/abs(YDist),colHn,l+1) =1;
                elseif YDist>0
                    H(rowHn+1,colHn+XDist/abs(XDist),l+1) =1;
                elseif YDist<0
                    H(rowHn-1,colHn+XDist/abs(XDist),l+1) =1;
                end
            end

        end
        S(rowHn,colHn) =1;
    end
end
answer = sum(S,'all')+1;
end

