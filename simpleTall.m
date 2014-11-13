function dst = simpleTall(src, im_pts, ratio)
seg_pts = divideIntoParts(im_pts);
part1 = src(1:seg_pts(1), :, :);
part2 = src(seg_pts(1) + 1:seg_pts(2), :, :);
part3 = src(seg_pts(2) + 1:seg_pts(3), :, :);
part4 = src(seg_pts(3) + 1:seg_pts(4), :, :);
part5 = src(seg_pts(4) + 1:end, :, :);

part2 = imresize(part2, [round(size(part2,1) * ratio * 0.9), size(part2,2)]);
part3 = imresize(part3, [round(size(part3,1) * ratio * 1), size(part3,2)]);
part4 = imresize(part4, [round(size(part4,1) * ratio * 1.1), size(part4,2)]);
dst = cat(1, part1, part2, part3, part4, part5);

function seg_pts = divideIntoParts(im_pts)
% 3 4 (12 15) (13 16)
seg_pts = zeros(4,1);
seg_pts(1) = im_pts(3,2);
seg_pts(2) = im_pts(4,2);
seg_pts(3) = (im_pts(12,2) + im_pts(15,2)) / 2;
seg_pts(4) = (im_pts(13,2) + im_pts(16,2)) / 2;
