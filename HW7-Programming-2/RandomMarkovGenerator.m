function [ output ] = RandomMarkovGenerator( input_filename )
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
size = 10^6;
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

output = int8(output - 1);
bin_vec = dec2bin(output, 2);
bin_vec = reshape(bin_vec', [], 1);
bin_vec_shaped = reshape(bin_vec, 16, [])';
bin_vec = uint16(bin2dec(bin_vec_shaped));
fileID = fopen(input_filename, 'wb');
fwrite(fileID, bin_vec, 'uint16');
fclose(fileID);
end