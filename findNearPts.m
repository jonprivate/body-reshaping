function critic_pts = findNearPts(im_pts, super_segs)
% inputs are:
% im_pts --- the manually labeled/automatically detected body edge points
% super_segs --- the superpixel segemented image
% output is:
% critic_pts --- the proper points on the edge of superpixel regions
% and nearest to the body edge points

critic_pts = zeros(size(im_pts));

for i = 1:size(im_pts,1)
    x = im_pts(i, 1);
    y = im_pts(i, 2);
	label = super_segs(y, x);
    [I,J] = find(super_segs == label);
    pts = [J,I];
    
    min_pt = pts(1, :);
    min_dst = Inf;
    for n = 1:numel(I)
        if isOnEdge(label, super_segs(pts(n,2)-1:pts(n,2)+1, pts(n,1)-1:pts(n,1)+1))
            dst = norm(pts(n, :) - im_pts(i,:));
            if dst < min_dst
                min_dst = dst;
                min_pt = pts(n, :);
            end
        end
    end
    critic_pts(i, :) = min_pt;
end

function result = isOnEdge(label, patch)
ind = find(patch ~= label);
result = ~isempty(ind);