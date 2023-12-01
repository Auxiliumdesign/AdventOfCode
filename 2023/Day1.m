data = readlines("input.txt")
%Part 1
calibvalue = 0;
for i = 1:length(data)
  numberIndex = [max([min(strfind(data(i),"0")), 0]), max([min(strfind(data(i),"1")), 0]), max([min(strfind(data(i),"2")), 0]), max([min(strfind(data(i),"3")), 0]), max([min(strfind(data(i),"4")), 0]), max([min(strfind(data(i),"5")), 0]), max([min(strfind(data(i),"6")), 0]), max([min(strfind(data(i),"7")), 0]), max([min(strfind(data(i),"8")), 0]), max([min(strfind(data(i),"9")), 0])];
  numberIndex(numberIndex==0) = 9999;
  [index2 , B1] = min(numberIndex);
 numberIndex = [max([max(strfind(data(i),"0")), 0]), max([max(strfind(data(i),"1")), 0]), max([max(strfind(data(i),"2")), 0]), max([max(strfind(data(i),"3")), 0]), max([max(strfind(data(i),"4")), 0]), max([max(strfind(data(i),"5")), 0]), max([max(strfind(data(i),"6")), 0]), max([max(strfind(data(i),"7")), 0]), max([max(strfind(data(i),"8")), 0]), max([max(strfind(data(i),"9")), 0])];
  [index1 , B2] = max(numberIndex);
  number1 = B1-1;
  number2 = B2-1;
  calibvalue = calibvalue +  number1*10 + number2;
end
calibvalue
%Part 2
calibvalue = 0;
for i = 1:length(data)
  numberIndex = [max([min(strfind(data(i),"0")), 0]),max([min(strfind(data(i),"zero")), 0]), max([min(strfind(data(i),"1")), 0]),max([min(strfind(data(i),"one")), 0]), max([min(strfind(data(i),"2")), 0]),max([min(strfind(data(i),"two")), 0]), max([min(strfind(data(i),"3")), 0]),max([min(strfind(data(i),"three")), 0]), max([min(strfind(data(i),"4")), 0]),max([min(strfind(data(i),"four")), 0]), max([min(strfind(data(i),"5")), 0]),max([min(strfind(data(i),"five")), 0]), max([min(strfind(data(i),"6")), 0]),max([min(strfind(data(i),"six")), 0]), max([min(strfind(data(i),"7")), 0]),max([min(strfind(data(i),"seven")), 0]), max([min(strfind(data(i),"8")), 0]),max([min(strfind(data(i),"eight")), 0]),max([min(strfind(data(i),"nine")), 0]), max([min(strfind(data(i),"9")), 0])];
  numberIndex(numberIndex==0) = 9999;
  [index2 , B1] = min(numberIndex);
  numberIndex = [max([max(strfind(data(i),"0")), 0]),max([max(strfind(data(i),"zero")), 0]), max([max(strfind(data(i),"1")), 0]),max([max(strfind(data(i),"one")), 0]), max([max(strfind(data(i),"2")), 0]),max([max(strfind(data(i),"two")), 0]), max([max(strfind(data(i),"3")), 0]),max([max(strfind(data(i),"three")), 0]), max([max(strfind(data(i),"4")), 0]),max([max(strfind(data(i),"four")), 0]), max([max(strfind(data(i),"5")), 0]),max([max(strfind(data(i),"five")), 0]), max([max(strfind(data(i),"6")), 0]),max([max(strfind(data(i),"six")), 0]), max([max(strfind(data(i),"7")), 0]),max([max(strfind(data(i),"seven")), 0]), max([max(strfind(data(i),"8")), 0]),max([max(strfind(data(i),"eight")), 0]),max([max(strfind(data(i),"nine")), 0]), max([max(strfind(data(i),"9")), 0])];
  [index1 , B2] = max(numberIndex);
  number1 = round((B1/2)-1);
  number2 = round((B2/2)-1);
  calibvalue = calibvalue +  number1*10 + number2;
end
calibvalue
