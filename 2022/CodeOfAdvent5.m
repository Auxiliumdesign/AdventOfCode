    clear all
    S1 = readlines('5_1.csv');
    S2 = readlines('5_2.csv');
    cargoOrig = zeros (8,9);
    Values = zeros(length(S2),3);

    for i = 1:length(S1) 
        k = strfind(S1(i),"[");
        for u = 1:length(k)
            pos = floor((k(u)-1)/4);
            cargoOrig(length(S1)-i+1,pos+1) = double(S1{i,1}(k(u)+1:k(u)+1));
        end
    end
    for i = 1:length(S2)
         Values(i,:) = cellfun(@str2double, regexp(S2{i}, '\d+', 'match'));
    end
%% part 1
        cargo = cargoOrig;
    for i = 1:length(Values)
        %For how many moves, do one move
        for j = 1:Values(i,1)
        k = find(cargo(:,Values(i,2)));
        temp = cargo(max(k),Values(i,2));
        cargo(max(k),Values(i,2)) = 0;
        k = find(cargo(:,Values(i,3)));
        if isempty(k)
            k = 0;
        end
        cargo(max(k)+1,Values(i,3)) = temp;
        end
    end
    for i = 1:width(cargo)
        word(i) = char(cargo(find(cargo(:,i),1,"last"),i));
    end
    part1 = word

    %% part 2
    cargo = cargoOrig;
    for i = 1:length(Values)
        %For how many moves, do one move
        k = find(cargo(:,Values(i,2)));
        temp = cargo(max(k)-(Values(i,1)-1):max(k),Values(i,2));
        cargo(max(k)-(Values(i,1)-1):max(k),Values(i,2)) = 0;
        k = find(cargo(:,Values(i,3)));
        if isempty(k)
            k = 0;
        end
        cargo(max(k)+1:max(k)+Values(i,1),Values(i,3)) = temp;
    end
    for i = 1:width(cargo)
        word(i) = char(cargo(find(cargo(:,i),1,"last"),i));
    end
    part2 = word
    