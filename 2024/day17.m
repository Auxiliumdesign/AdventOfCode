clear all;
% Read the input file
% Read the file
A = 0
B = 0
C = 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%OUTPUTS B

prog = [2,4,1,3,7,5,1,5,0,3,4,2,5,5,3,0]
counter = 0;
inst = 1
output = []
tic
progLen = length(prog)
while ~isequal(output,prog)
    inst = 1;
    output = [];
    A = counter;
    B = 0;
    C = 0;
    % if mod(counter,100000) == 0
    %     toc
    %     counter
    %     tic
    % end

while inst < progLen
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
            end
        case 6
            B = bitshift(A, -getComboOperand(oper,A,B,C));
        case 7


            C = bitshift(A, -getComboOperand(oper,A,B,C)); % Faster than floor(A / 2^x)


    end

    inst = inst + 2;
end
counter = counter + 1;
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
