function [ output ] = ArithmLaplace( input_filename, input )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(input_filename, 'rb');
data = fread(fileID, 'uint16');
fclose(fileID);
bin_data = dec2bin(data, 16);
end