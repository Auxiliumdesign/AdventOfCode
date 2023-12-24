clear all
data = readlines("Input.txt");
for i = 1:height(data)
    strings = strsplit(data(i),'@')
    pos(i,:) = double(strsplit(strings(1),','));
    vel(i,:) = double(strsplit(strings(2),','));
end

testArea = [200000000000000,400000000000000];

px1 = pos(:,1);
py1 = pos(:,2);
pz1 = pos(:,3);
vx = vel(:,1);
vy = vel(:,2);
vz = vel(:,3);


t(:,1) = (testArea(1) - px1)./vx;
t(:,2) = (testArea(2) - px1)./vx;
t(:,3) = (testArea(1) - py1)./vy;
t(:,4) = (testArea(2) - py1)./vy;

tMax = max(t,[],2);

px2 = px1+vx.*tMax;
py2 = py1+vy.*tMax;
counter = 0

%[xi,yi,ii] = polyxpoly(px1(1),py1(1),px2(1),py2(1))
for k = 1:height(py2)-1
    for j = 1:height(py2)
        if j>k
        x1 = px1(k);
        x2 = px2(k);
        x3 = px1(j);
        x4 = px2(j);
        y1 = py1(k);
        y2 = py2(k);
        y3 = py1(j);
        y4 = py2(j);
        t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
        u = ((x1-x3)*(y1-y2)-(y1-y3)*(x1-x2))/((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
        Px  = (x1+t*(x2-x1));
        Py  = (y1+t*(y2-y1));
        if u>=0 && u<=1 && t<=1 && t>=0 && Px<=testArea(2) && Px>=testArea(1) && Py<=testArea(2) && Py>=testArea(1)
            counter = counter + 1;
        end
        end
    end
end

part1 = counter

syms t1 t2 t3 pxr pyr pzr vxr vyr vzr
S = solve(...
    pos(1,1) + vel(1,1)*t1 == pxr+vxr*t1,...
    pos(1,2) + vel(1,2)*t1 == pyr+vyr*t1,...
    pos(1,3) + vel(1,3)*t1 == pzr+vzr*t1,...  
    pos(2,1) + vel(2,1)*t2 == pxr+vxr*t2,...
    pos(2,2) + vel(2,2)*t2 == pyr+vyr*t2,...
    pos(2,3) + vel(2,3)*t2 == pzr+vzr*t2,...
    pos(3,1) + vel(3,1)*t3 == pxr+vxr*t3,...
    pos(3,2) + vel(3,2)*t3 == pyr+vyr*t3,...
    pos(3,3) + vel(3,3)*t3 == pzr+vzr*t3)

part2 = S.pxr + S.pyr + S.pzr