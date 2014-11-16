close all; clear all;
directory = '../data/Jile_Hu/first/';
filename = 'IMG_0002.JPG';
im = imread([directory, filename]);
resize_ratio = 0.2;
im = imresize(im, resize_ratio);
[x, y] = readOne('IMG_0002.JPG');
x = double(x) * resize_ratio;
y = double(y) * resize_ratio;
num_samples = 5;

%% superpixels
% [super_segs, Isp] = superpixels(im);
% critic_pts = findNearPts(round([x y]), super_segs);
% critic_pts
% round([x y])
% 
% figure; imshow(mat2gray(Isp));
% hold on
% plot(x, y, '*b');
% plot(critic_pts(:,1), critic_pts(:,2), '*r');
% hold off

%% simple tall
% ratio = 1.1;
% result = simpleTall(im, [x y], ratio);
% 
% figure; imshow(im);
% figure; imshow(result);

%% initial
tmp = im;
add = 0;
im = zeros(size(tmp,1), size(tmp,2) + add*2, 3);
im(:,add+1:size(tmp,2)+add,:) = tmp;
x = x + add;

figure; imshow(im);
hold on
im1_pts = samples(x, y, num_samples);
plot(im1_pts(:,1), im1_pts(:,2), '*b');
hold off

tall_ratio = 1.1;
figure; imshow(im);
hold on
im2_pts = samples(x, y, num_samples, 'tall', tall_ratio);
plot(im2_pts(:,1), im2_pts(:,2), '*b');
hold off

warped_im = warp_trig(im, im1_pts, im2_pts, 1);
figure; imshow(uint8(warped_im));