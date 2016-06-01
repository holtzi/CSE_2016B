function [ ] = Decompress(compressed_file_name, dictionary_file_name)
%DECOMPRESS Summary of this function goes here
%   Detailed explanation goes here
%compressed_file_name = 'comressed_dictShannon.bin';
%dictionary_file_name = 'dictShannon.txt';
dict = fileread(dictionary_file_name);
fileID = fopen(compressed_file_name,'rb');
dec_encoded = uint8(fread(fileID,'uint8'));
fclose(fileID);
suffix_padding = dec_encoded(1);
dec_encoded = dec_encoded(2:end);
dict = strsplit(dict);
dict = dict(1:end-1);
dict = reshape(dict,2,length(dict)/2);
len_vect = cell(1,length(dict(1,:)));
for index = 1:length(dict(1,:))
    len_vect{index} = numel(dict{2,index});
end
dict(3,:) = len_vect(:);
len = length(dec_encoded);
str_encoded = repmat(char(0),1,len*8);
for index = 1:length(dec_encoded)
    str_encoded(1 + (index-1)*8:1 + (index-1)*8 + 7) = dec2bin(dec_encoded(index),8);
end
str_encoded = str_encoded(1:end-double(suffix_padding));
str_decoded = repmat(char(0),1,len*8);
[V, I] = sort(cell2mat((dict(3,:))));
str_idx = 1;
out_idx = 1;
step = numel(dict{1});
while str_idx<length(str_encoded)
    for sym_idx = I;
       if (str_encoded(str_idx:str_idx + dict{3,sym_idx}-1) == dict{2,sym_idx});
           str_decoded(out_idx:out_idx + step -1) = dict{1,sym_idx};
           str_idx = str_idx + dict{3,sym_idx};
           out_idx = out_idx + step;
           %disp(str_idx)
           break
       end
    end
end
str_decoded = str_decoded(1:out_idx-1);
out_file = ['decomressed_',dictionary_file_name(1:end-3),'txt'];
fileID = fopen(out_file, 'w');
fwrite(fileID,str_decoded);
fclose(fileID);
end