function boundary = getVertical(point, width, option, para)
switch option
    case 'end'
        dist = norm([para{1}(2) - para{1}(1), para{2}(2) - para{2}(1)]);
        cost = (para{1}(2) - para{1}(1)) / dist;
        sint = (para{2}(2) - para{2}(1)) / dist;
    case 'cos'
        cost = para{1};
        sint = para{2};
end
boundary = {zeros(size(point,1),2), zeros(size(point,1),2)};

% side 1
boundary{1}(:,1) = round(point(:,1) - width * sint);
boundary{1}(:,2) = round(point(:,2) - width * cost);
% side 2
boundary{2}(:,1) = round(point(:,1) + width * sint);
boundary{2}(:,2) = round(point(:,2) + width * cost);