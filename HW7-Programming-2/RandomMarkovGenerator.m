function [ output_args ] = RandomMarkovGenerator( input_filename )
%RANDOM_GENERATOR Summary of this function goes here
%   Detailed explanation goes here
a = 0.8;
b = 0.8;
c = 0.9;
d = 0.9;
A = [1-a a/5 0 4*a/5 
     4*b/5 1-b b/5 0
     0 4*c/5 1-c c/5
     d/5 0 4*d/5 1-d];
% A(row_index,:) - extract row
size = 10;
output = zeros(1,size);
sym_prob = rand(1,size);
output(1) = 2;
for index=1:size-1
    temp = cumsum( A(output(index),:));
    if (sym_prob(index) <= temp(1))
        output(index+1) = 1;
    elseif (sym_prob(index) <= temp(2))
        output(index+1) = 2;
    elseif (sym_prob(index) <= temp(3))
        output(index+1) = 3;
    elseif (sym_prob(index) <= temp(4))
        output(index+1) = 4;
    end
    
end

    
output = output - 1;
bin_vec = dec2bin(output, 2);
fileID = fopen('orig.bin', 'wb');
fclose(fileID);
end

