function [ ] = CompressFast(input_file_name, dictionary_file_name)
%COMPRESS Summary of this function goes here
%   Detailed explanation goes here
%input_file_name = 'orig.txt';
%dictionary_file_name = 'dictShannon.txt';
T1 = clock;

dict = fileread(dictionary_file_name);
input_vector = fileread(input_file_name);
dict = strsplit(dict);
dict = dict(1:end-1);
dict = reshape(dict,2,length(dict)/2);
s = struct();
for index = 1:length(dict)
    s = setfield(s, dict{1, index}, dict{2, index});
end

len = length(input_vector);
encoded = repmat(char(0),1,len*8);
offset = 0;

step = numel(dict{1});
for index = 1:step:length(input_vector)
    len_bit = length(s.(input_vector(index:index - 1 + step)));
    encoded(offset+1:offset+len_bit) = s.(input_vector(index:index - 1 + step));
    offset = offset + len_bit;
end
suffix_len = mod(8- mod(offset,8),8);
encoded(offset+1:offset+suffix_len) = repmat(char('0'),1,suffix_len);
encoded = encoded(1:offset+suffix_len);

dec_encoded = uint8(bin2dec(reshape(encoded,8,length(encoded)/8)'));
dec_encoded = [uint8(suffix_len) dec_encoded'];
out_file = ['compressed_',dictionary_file_name(1:end-3),'bin'];
fileID = fopen(out_file,'wb');
fwrite(fileID,dec_encoded,'uint8');
fclose(fileID);

T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) CompressFast input_file_name:',input_file_name, ' dictionary_file_name:', dictionary_file_name])
end