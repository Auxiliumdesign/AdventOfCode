clear all
format long g
S = readlines('11_1.csv');
monkeys = 8
ItemTable = zeros(monkeys,40);
OperationTable = S;
OperationTable(:,:) = "";
DeviceTable = zeros(monkeys,1);
Inspections = zeros(monkeys,1);
TruthTable = zeros(monkeys,2);
counter = 1;
new = 3;
%%
for i = 1:length(S)
    test1 = strfind(S(i),"Starting items:");
    test2 = strfind(S(i),"Operation:");
    test3 = strfind(S(i),"divisible ");
    test4 = strfind(S(i),"If true");
    if ~isempty(test1)
        Base = S{i}(test1+16:end);
        Go = erase(Base," ");
        Set = strsplit(Go,',');
        for k = 1:length(Set)
        ItemTable(counter,k) = str2double(Set{k});
        end
        
    end
     if ~isempty(test2)
        OperationTable(counter) = S{i}(test2+11:end);
    end
     if ~isempty(test3)
        DeviceTable(counter) = str2double(S{i}(test3+13:end));
     end
     if ~isempty(test4)
         S{i}(test4+13:end)
        TruthTable(counter,1) = str2double(S{i}(end:end));
        TruthTable(counter,2) = str2double(S{i+1}(end:end));
        counter = counter +1;
    end
end

TruthTable = TruthTable +1;
for o = 1:20
for i = 1:monkeys
    for j = 1:length(find(ItemTable(i,:)))
        Inspections(i) = Inspections(i)+1;
        old = ItemTable(i,j);
        eval(OperationTable(i)+';');
        %new = floor(new/3);
        new = mod(new,7*19*5*11*13*2*3*17);
        ItemTable(i,j) = 0;
        if mod(new,DeviceTable(i)) == 0
            ThrowItems = length(find(ItemTable(TruthTable(i,1),:)));
            ItemTable(TruthTable(i,1),ThrowItems+1) = new;
        else
            ThrowItems = length(find(ItemTable(TruthTable(i,2),:)));
            ItemTable(TruthTable(i,2),ThrowItems+1) = new;
        end
    end
end
end
toc
Inspections = sort(Inspections,1,"descend")
part1 = Inspections(1)*Inspections(2)

% For part2, remove comment of line 49 and change the o from 20 to 10000

%%