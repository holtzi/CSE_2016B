function [ ] = CreateDictShanon( input_filename )
%CREATEDICTSHANON Summary of this function goes here
%   Detailed explanation goes here
%input_filename = 'orig.txt';
T1 = clock;
[ ent, ent_lst, p_lst ,s] = CalculateEntropiesPerSym( input_filename, 1);
[sorted_p, p_idx] = sort(p_lst,'descend'); 
sorted_p_cumsum = cumsum([0 ,sorted_p(1:end-1)]);
sym_bin_len = ceil(-log2(sorted_p));
decvector = floor(sorted_p_cumsum.*(2.^sym_bin_len));
sym_bin_len2(p_idx) = sym_bin_len(1:end);
decvector2(p_idx) = decvector(1:end);

fileID = fopen('dictShannon.txt', 'w');
fn = fieldnames(s);
bin_sym = cell(1,length(fn));
for index = 1:length(fn);
    bin_sym{index} = dec2bin(decvector2(index), sym_bin_len2(index));
    fprintf(fileID,'%s %s\n', fn{index},bin_sym{index});
end
fclose(fileID);
T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) CreateDictShanon input_file_name:',input_filename])
end