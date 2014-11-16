function [Idisp, Isp] = superpixels(Irgb)

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
Ibuff=uint32(Ibuff);

%[Iout,Ilabel]=interface(Ibuff,m,n,2000,20); %%%%20000->number of superpixels   20-> from 10~40, little influence
[Iout,Ilabel]=interface(Ibuff,m,n,2000,40); %%%%20000->number of superpixels   20-> from 10~40, little influence

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
