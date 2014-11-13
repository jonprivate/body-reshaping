function [x, y] = readOne(filename)
record_file_name = 'record';
N = 16;
file_handler = fopen(record_file_name, 'r');
while ~feof(file_handler)
    C = textscan(file_handler,'%s',1);
    if strcmp(C{1},filename) == 1
        data = textscan(file_handler, '%d %d', N);
        x = data{1};
        y = data{2};
        fclose(file_handler);
        return;
    else
        textscan(file_handler, '%d %d', N);
    end
end
fclose(file_handler);
x = [];
y = [];
return;