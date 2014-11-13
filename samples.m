function im_pts = samples(x, y, num_samples, warp_mode, warp_ratio)
x = double(x);
y = double(y);
% for each line (pair of points), find all the points on the line
width = norm([x(2) - x(1), y(2) - y(1)]);
ratio = [0.45 0.7 0.2 0.2 0.2 0.2 0.3 0.3 0.3 0.3];
option = 'end';
step = [2 2 1 2 1 2 1 2 1 0];
if nargin == 5
    switch warp_mode
        case 'fat'
            ratio = ratio * warp_ratio;
        case 'tall'
            center = [(x(4) + x(11) + x(14)) / 3, (y(4) + y(11) + y(14)) / 3];

            upper_ind = [3 5 8];
            midup_ind = [6 9];
            middw_ind = [12 15];
            lower_ind = [13 16];

            x_rel = x - center(1);
            y_rel = y - center(2);

            y_rel(upper_ind) = y_rel(upper_ind) * warp_ratio * 0.9;
            y_rel(midup_ind) = y_rel(midup_ind) * warp_ratio * 0.9;
            y_rel(middw_ind) = y_rel(middw_ind) * warp_ratio * 1;
            y_rel(lower_ind) = y_rel(lower_ind) * warp_ratio * 1;
            y_rel(1) = y_rel(3) + y(1) - y(3);
            y_rel(2) = y_rel(3) + y(2) - y(3);

            x = x_rel + center(1);
            y = y_rel + center(2);
    end
end
plot(x, y, '*r');
ind = 1;
i = 1;
im_pts = [];
while i <= 10
    pointsOnLine = double( getLine(x(ind:ind+1), y(ind:ind+1), num_samples) );
    para = {x(ind:ind+1), y(ind:ind+1)};
    boundary = getVertical(pointsOnLine, width * ratio(i), option, para);
    if ~(i == 1 || i == 2)
        im_pts = [im_pts; boundary{1}];
        im_pts = [im_pts; boundary{2}];
    end
%     im_pts = [im_pts; boundary{1}];
%     im_pts = [im_pts; boundary{2}];
    ind = ind + step(i);
    i = i + 1;
end