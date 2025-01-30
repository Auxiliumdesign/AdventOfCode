clear all;
prog = [2,4,1,3,7,5,1,5,0,3,4,2,5,5,3,0]
CurrentValues = [1,2,3,4,5,6,7]
position = length(prog)
while position > 0
    tempArray=[]
    for i = 1:length(CurrentValues)
        A = CurrentValues(i)
        output = mod(bitxor(bitxor(bitxor(mod(A,8),3),5), floor(A / 2^(bitxor(mod(A, 8),3)))), 8);
        if output == prog(position)
            tempArray = [tempArray,CurrentValues(i)]
        end
    end
    NextValues = []
    for i = 1:length(tempArray)
        next7 = tempArray(i)*8:tempArray(i)*8+7;
        NextValues = [NextValues,next7]
    end
    position = position -1
    CurrentValues = NextValues
end
part2 = NextValues(1)/8



%%
testers = NextValues
for run = 1:length(testers)
A = testers(run)
output2 = mod(bitxor(bitxor(bitxor(mod(A,8),3),5), floor(A / 2^(bitxor(mod(A, 8),3)))), 8);
if output2 == 2
testers(run)
end
end
output2 = [];
output2 = zeros(1,1000000);
tic
for A = 393:393
output2 = mod(bitxor(bitxor(bitxor(mod(A,8),3),5), floor(A / 2^(bitxor(mod(A, 8),3)))), 8);
end
toc
testers = find(output2==0);
%%
% C = A / 2^((A mod 8) XOR 011)
% A = A / 2^3
% B =  (((A mod 8) XOR 011) XOR 101) XOR C
% Output = (((A mod 8) XOR 011) XOR 101) XOR (A / 2^((A mod 8) XOR 011)) mod 8
 prog = [2,4,1,3,7,5,1,5,0,3,4,2,5,5,3,0]
for run = 1:length(testers)
    A=201320;
    output = [];
        if mod(testers(run),100000) == 0
        toc
        testers(run)
        tic
    end
    while isequal(output,prog(1:length(output))) || isempty(output)
        try

     output = [output,mod(bitxor(bitxor(bitxor(mod(A,8),3),5), floor(A / 2^(bitxor(mod(A, 8),3)))), 8)];
        if output == 2
        "here"
        end
     A = floor(A / 8);
             if isequal(output, [2,4,1])
                testers(run)
            end
        catch

            break

        end
        
    end
end

prog = [2,4,1,3,7,5,1,5,0,3,4,2,5,5,3,0]
counter = 0;
inst = 1
output = []
tic
progLen = length(prog)
%for counter = 4:8:10000000000
for counter = 1:6624
    % if mod(counter,2048)~= 1140 && mod(counter,2048)~= 1076
    %     continue
    % end
    output = [];
    if isequal(output,prog)
        counter
    end
    inst = 1;
    output = [];
    A = counter;
    B = 0;
    C = 0;
    if mod(counter,100000) == 0
        toc
        counter
        tic
    end



while inst < progLen
    if inst == 15
     C1 = floor(A / 2^(bitxor(mod(A, 8),3)));
     A1 = floor(A / 8);
    B1 = bitxor(bitxor(bitxor(mod(A, 8),3),5),C1);
    Output = mod(bitxor(bitxor(bitxor(mod(A,8),3),5), floor(A / 2^(bitxor(mod(A, 8),3)))), 8);
    end
    op = prog(inst);
    oper = prog(inst+1);
    switch op
        case 0
            A = bitshift(A, -getComboOperand(oper,A,B,C));

        case 1
            B = bitxor(B,oper);

        case 2
            B = mod(getComboOperand(oper,A,B,C),8);

        case 3
            if A ~= 0
                if inst ~= oper
                    inst = oper - 1 ;
                else
                    inst = oper;
                end
            end

        case 4

            B = bitxor(B,C);
        case 5
            output = [output,mod(getComboOperand(oper,A,B,C),8)];
            if ~isequal(output,prog(1:length(output)))
                break
            elseif length(output)==2
                counter
            end
        case 6
            B = bitshift(A, -getComboOperand(oper,A,B,C));
        case 7


            C = bitshift(A, -getComboOperand(oper,A,B,C)); % Faster than floor(A / 2^x)


    end

    inst = inst + 2;
end
end


function output = getComboOperand(oper, A, B, C)
if oper >= 0 && oper<=3
    output = oper;
elseif oper == 4
    output = A;
elseif oper == 5
    output = B;
elseif oper == 6
    output = C;
elseif oper == 7

end
end
