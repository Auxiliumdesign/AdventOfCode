clear all
part1 = elfGame("2_1.csv",1)
part2 = elfGame("2_1.csv",2)
%%
function total_score = elfGame(filename,part)
    strategy = readtable(filename,'ReadVariableNames',false,'Delimiter',' ');
    strategy = table2cell(strategy);
    playMap = containers.Map({'AX','BX', 'CX', 'AY', 'BY', 'CY','AZ','BZ','CZ'}, {'Z','X','Y','X','Y','Z','Y','Z','X'});
    score_map = containers.Map({'A', 'B', 'C', 'X', 'Y', 'Z'}, {1, 2, 3, 1, 2, 3});
    win_map = containers.Map({'BZ', 'AY', 'CX'}, {6, 6, 6});
    draw_map = containers.Map({'AX', 'BY', 'CZ'}, {3, 3, 3});
    total_score = 0;
    for i = 1:size(strategy, 1)
        move = strategy(i,:);
        if part == 2  
            move{2} = playMap([move{1}, move{2}]);
        end
        my_score = score_map(move{2});  
        if win_map.isKey([move{1}, move{2}])
            total_score = total_score + my_score + win_map([move{1}, move{2}]);
        elseif draw_map.isKey([move{1}, move{2}])
            total_score = total_score + my_score + draw_map([move{1}, move{2}]);
        else
            total_score = total_score + my_score;
        end
    end
end