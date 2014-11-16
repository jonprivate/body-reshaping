function warped_im = warp_trig(im, src_pts, dst_pts, warp_frac)
[nr, nc, ~] = size(im);
src_pts = [src_pts; 0, 0; 0, nr; nc, nr; nc, 0];
dst_pts = [dst_pts; 0, 0; 0, nr; nc, nr; nc, 0];
tri = delaunay(dst_pts);

% Check whether the number of control points in both images the same
assert(size(src_pts, 1) == size(dst_pts, 1),'Control points in two images should be the same amount!');

% Initialize
tri_num    = size(tri,1);
im_warp   = zeros(nr, nc, 3);
sub_array  = [repmat(1:nc, 1, nr); reshape(repmat(1:nr, nc, 1), [1 nr*nc]); ones(1, nr*nc)];
ps       = zeros(3, nr * nc);

% Intermediate points
imwarp_pts = (1 - warp_frac) * src_pts + warp_frac * dst_pts;

% Loop for each triangle to calculate the transform matrix
row_ind = mytsearch(imwarp_pts(:,1), imwarp_pts(:,2), tri, sub_array(1,:)', sub_array(2,:)');
for i = 1 : tri_num
    tf_warp               = [[imwarp_pts(tri(i, 1), :); imwarp_pts(tri(i, 2), :); imwarp_pts(tri(i, 3),:)]'; ones(1,3)];
    tf                  = [[src_pts(tri(i, 1), :); src_pts(tri(i, 2), :); src_pts(tri(i, 3), :)]'; ones(1,3)] / tf_warp;
    ps(:, row_ind == i) = pixel_limit(tf * sub_array(:, row_ind == i), nr, nc);
end

% Loop for each pixel
for i = 1 : nr*nc
   if isnan(row_ind(i))
       continue;
   end
   im_warp(sub_array(2,i), sub_array(1,i), :) = im(ps(2, i), ps(1, i), :);
end

% Dissolve two warpped images
warped_im = im_warp;
