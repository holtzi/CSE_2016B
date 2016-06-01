function [ output ] = ArithmLaplace( input_filename, input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(input_filename, 'rb');
data = fread(fileID, 'uint16');
fclose(fileID);
bin_data = dec2bin(data, 16);
bin_data_stream = reshape(bin_data', [], 1);
bin_data_nums = reshape(bin_data_stream, 2, [])';
data_input = bin2dec(bin_data_nums);
end