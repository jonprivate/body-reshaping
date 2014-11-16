close all; clear all;
directory = '../data/Jile_Hu/first/';
filename = 'IMG_0002.JPG';
im = imread([directory, filename]);
resize_ratio = 0.5;
im = imresize(im, resize_ratio);
figure;
imshow(im);
hold on

im1_pts = [];
im2_pts = [];
[x, y] = readOne('IMG_0002.JPG');
x = double(x) * resize_ratio;
y = double(y) * resize_ratio;
% for each line (pair of points), find all the points on the line
width = norm([x(2) - x(1), y(2) - y(1)]);
ratio = [0.45 0.7 0.2 0.2 0.2 0.2 0.3 0.3 0.3 0.3];
option = 'end';
num = 10;
% segments = [1 3 5 6 8 9 11 12 14 15];
step = [2 2 1 2 1 2 1 2 1 0];
ind = 1;
i = 1;
num_samples = 5;
while i <= 10
    pointsOnLine = double( getLine(x(ind:ind+1), y(ind:ind+1), num_samples) );
    para = {x(ind:ind+1), y(ind:ind+1)};
    boundary = getVertical(pointsOnLine, width * ratio(i), option, para);
    if ~(i == 1 || i == 2)
        im1_pts = [im1_pts; boundary{1}];
        im1_pts = [im1_pts; boundary{2}];
    end
    plot(pointsOnLine(:,1), pointsOnLine(:,2), 'g*');
    plot(boundary{1}(:,1), boundary{1}(:,2), 'r*');
    plot(boundary{2}(:,1), boundary{2}(:,2), 'b*');
    ind = ind + step(i);
    i = i + 1;
    pause
end
hold off

fat_ratio = 0.8;
ind = 1;
i = 1;
while i <= 10
    pointsOnLine = double( getLine(x(ind:ind+1), y(ind:ind+1), num_samples) );
    para = {x(ind:ind+1), y(ind:ind+1)};
    boundary = getVertical(pointsOnLine, width * ratio(i) * fat_ratio, option, para);
    if ~(i == 1 || i == 2)
        im2_pts = [im2_pts; boundary{1}];
        im2_pts = [im2_pts; boundary{2}];
    end
    ind = ind + step(i);
    i = i + 1;
end

%%
% Run script of image morphing for CIS 581 Project 2
% Written by Qiong Wang at University of Pennsylvania
% Oct. 9th, 2013

% Clear up
warped_im = warp_trig(im, im1_pts, im2_pts, 1);
figure; imshow(uint8(warped_im));