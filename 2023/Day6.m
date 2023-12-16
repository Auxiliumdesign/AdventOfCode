clear all
%% Part 1
t = [48,87,69,81]
Dist = [255,1288,1117,1623]
val = 1;
for r = 1:length(t)
val= val * (1+(floor((t(r) + sqrt(t(r)*t(r) - 4 * (Dist(r)+1)))/2))- (ceil((t(r) - sqrt(t(r)*t(r) - 4 * Dist(r)+1))/2)));
end
part = val

%% For part 2 just remove , in input.