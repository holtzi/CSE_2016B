function [ ] = CreateDictHuff( input_filename, sym_len)
%CREATEDICTHUFF Summary of this function goes here
%   Detailed explanation goes here
%input_filename = 'orig.txt';
%sym_len = 2;
T1 = clock;
[ ent, ent_lst, p_lst ,s] = CalculateEntropiesPerSym( input_filename,sym_len);
symbols = find(p_lst~=0);
p_lst = p_lst(symbols);

%p_lst_orig = p_lst;
% sort using the frequency
[p_lst,sortindex] = sort(p_lst);
%sortindex_orig = sortindex;
symbols = symbols(sortindex);

len = length(symbols);
symbols_index = num2cell(1:len);
codeword_tmp = cell(len,1);
while length(p_lst)>1;
	index1 = symbols_index{1};
	index2 = symbols_index{2};
	codeword_tmp(index1) = addnode(codeword_tmp(index1),uint8(0));
	codeword_tmp(index2) = addnode(codeword_tmp(index2),uint8(1));
	p_lst = [sum(p_lst(1:2)) p_lst(3:end)];
	symbols_index = [{[index1 index2]} symbols_index(3:end)];
	% resort data in order to have the two nodes with lower frequency as first two
	[p_lst,sortindex] = sort(p_lst);
	symbols_index = symbols_index(sortindex);
end

% arrange cell array to have correspondance simbol <-> codeword
codeword = cell(26^sym_len,1);
codeword(symbols) = codeword_tmp;

fileID = fopen(sprintf('dictHuffman%d.txt',sym_len), 'w');
fn = fieldnames(s);
for idx = 1:length(fn);
    if ~isempty(double(codeword{idx}))
        fprintf(fileID,'%s %s\n', fn{idx},sprintf('%d',double(codeword{idx})));
    end
end
fclose(fileID);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function codeword_new = addnode(codeword_old,item)
    codeword_new = cell(size(codeword_old));
    for index = 1:length(codeword_old),
        codeword_new{index} = [item codeword_old{index}];
    end
end
T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) CreateDictHuff input_file_name:',input_filename])
end

