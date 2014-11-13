function pointsOnLine = getLine(x,y,leng)
x = round(x);
y = round(y);
if nargin < 3
    if abs(x(2) - x(1)) > abs(y(2) - y(1))
        leng = abs(x(2) - x(1));
    else
        leng = abs(y(2) - y(1));
    end
end

pointsOnLine = zeros(leng, 2);
xstep = (x(2) - x(1)) / leng;
ystep = (y(2) - y(1)) / leng;
pointsOnLine(1,:) = [x(1), y(1)];
for i = 2 : leng
    pointsOnLine(i, :) = pointsOnLine(i - 1, :) + [xstep, ystep];
end
pointsOnLine = round(pointsOnLine);