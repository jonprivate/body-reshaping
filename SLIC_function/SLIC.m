close all; clear all;
Irgb=imread('00000000.jpg');
[m,n,c]=size(Irgb);

sz=m*n;
Ibuff=zeros(1,sz);

k=1;
for i=1:m
    for j=1:n
        Ibuff(k)=uint32( bitshift( uint32(Irgb(i,j,1)) ,16)+bitshift( uint32(Irgb(i,j,2)) ,8)+ uint32(Irgb(i,j,3)));
        k=k+1;
    end
end
% 
Ibuff=uint32(Ibuff);
figure; imshow(mat2gray(reshape(Ibuff,n,m)));

%[Iout,Ilabel]=interface(Ibuff,m,n,2000,20); %%%%20000->number of superpixels   20-> from 10~40, little influence
[Iout,Ilabel]=interface(Ibuff,m,n,200,40); %%%%20000->number of superpixels   20-> from 10~40, little influence

Isp=zeros(m,n,3);
Idisp=zeros(m,n);
k=1;
for i=1:m
    for j=1:n
        Isp(i,j,1)=bitshift( bitand(Iout(k),16711680) ,-16);
        Isp(i,j,2)=bitshift( bitand(Iout(k),65280) ,-8);
        Isp(i,j,3)=bitand(Iout(k), 255);
        Idisp(i,j)=Ilabel(k);
        k=k+1;
    end
end

% Idot = zeros(m,n);
% for i = 2:m-1
%     for j = 2:n-1
%         if Idisp(i,j) ~= Idisp(i-1,j) || Idisp(i,j) ~= Idisp(i+1,j) || Idisp(i,j) ~= Idisp(i,j-1) || Idisp(i,j) ~= Idisp(i,j+1)
%             C = unique(Idisp(i-1:i+1, j-1:j+1));
%             if numel(C) >= 3
%                 Idot(i,j) = 1;
%             end
%         end
%     end
% end
% Idot = bwmorph(Idot, 'shrink', Inf);

% figure;
% imshow(Idot);
figure;
imshow(mat2gray(Isp));
figure;
imagesc(mat2gray(Idisp));