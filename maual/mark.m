directory = './Jile_Hu/first';
listing = dir(directory);

close all;
figure;
record_file_name = 'record';
file_handler = fopen(record_file_name, 'a');
N = 16;
for i = 3 : length(listing)
    f = imread(listing(i).name);
    imshow(f);
    %[x, y] = ginput(N);
    fprintf(file_handler,'%s\n',listing(i).name);
    for j = 1:N
        fprintf(file_handler,'%d\t%d\n',x(j),y(j));
    end
end
fclose(file_handler);