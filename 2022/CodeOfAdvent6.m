clear all
S = readlines('6_1.csv')
N = convertStringsToChars(S)
%% Part 1 and 2
part1 = calcMarkers(4,N)
part2 = calcMarkers(14,N)

function answer = calcMarkers(numMarker, markerString)
    for i = 0:length(markerString)
        C = unique(markerString(1:numMarker));
        if length(C) == numMarker 
            answer = i + numMarker;
          break
        end
        markerString = circshift(markerString,-1);
    end
end
