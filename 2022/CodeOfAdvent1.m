clear all
S = readlines('1_1.csv');
A = blankLineSeparated(S)
Calories = sumCellArray(A,'row','sorted')
%part 1
part1 = Calories(1)
%part 2
part2 = sum(Calories(1:3))



