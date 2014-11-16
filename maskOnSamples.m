function mask = maskOnSamples(im_pts, im_size)
BW = zeros(im_size(1), im_size(2));
for i = 1:size(im_pts,1)
    BW(im_pts(i,2), im_pts(i,1)) = 1;
end
mask = bwconvhull(BW);