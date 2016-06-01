function [] = DecompressFast(compressed_file_name, dictionary_file_name)
T1 = clock;
dict = fileread(dictionary_file_name);
fileID = fopen(compressed_file_name,'rb');
dec_encoded = uint8(fread(fileID,'uint8'));
fclose(fileID);
suffix_padding = dec_encoded(1);
dec_encoded = dec_encoded(2:end);
dict = strsplit(dict);
dict = dict(1:end-1);
dict = reshape(dict,2,length(dict)/2);
step = numel(dict{1});
for i = 1:length(dict)
   dict{2,i} =  double(dict{2,i})-48;
end

% Build a binary tree to help the decoding process
tree = zeros(1,4);
% For each codeword...
for codeword_index = 1:length(dict)
    % Start at the root node
    node = 1;
    % For every bit in the codeword, except for the last...
    for bit_index = 1:(length(dict{2,codeword_index})-1)
        % If the bit is a 0...
        if dict{2,codeword_index}(bit_index) == 0
            % If a node has not been created to handle the sequence of bits in the codeword so far...
            if tree(node,1) == 0
                % ...create a node and a branch to it
                tree(node,1) = size(tree,1)+1;
                tree(size(tree,1)+1,:) = zeros(1,4);  
            end
            % Navigate to the node that handles the sequence of bits in the codeword so far
            node = tree(node,1);
        % ...else the bit is a 1
        else
            % If a node has not been created to handle the sequence of bits in the codeword so far...
            if tree(node,2) == 0
                % ...create a node and a branch to it
                tree(node,2) = size(tree,1)+1;
                tree(size(tree,1)+1,:) = zeros(1,4);  
            end
            % Navigate to the node that handles the sequence of bits in the codeword so far
            node = tree(node,2);
        end
    end
    % If the final bit in the codeword is a 0...
	if dict{2,codeword_index}(length(dict{2,codeword_index})) == 0
        % Associate the current node with the codeword index and create a branch back to the root node
        tree(node,1) = 1;
        tree(node,3) = codeword_index;
    % ...else the final bit is a 1
	else
        % Associate the current node with the codeword index and create a branch back to the root node
        tree(node,2) = 1;
        tree(node,4) = codeword_index;
	end
end


len = length(dec_encoded);

str_encoded = double(dec2bin(dec_encoded,8))-48;
str_encoded = str_encoded';
str_encoded = str_encoded(:);
str_encoded = str_encoded';
str_encoded = str_encoded(1:end-double(suffix_padding));
str_decoded = repmat(char(0),1,len*8);
% Decoder
% =======

% Create an empty vector to store the recovered symbols in
% Start at the root node of the binary tree
node = 1;
idx = 1;
% For each bit...
for bit_index = 1:length(str_encoded)
    % If the bit is a 0...
    if str_encoded(bit_index) == 0
        % If the node is associated with a codeword index...
        if tree(node,3) ~= 0
            % ...concatenate the codeword index onto the sequence of symbols recovered so far
            str_decoded(idx:idx+step-1) =  dict{1,tree(node,3)};
            idx = idx + step;
        end
        % Navigate to the next node
        node = tree(node,1);
    else
        % If the node is associated with a codeword index...
        if tree(node,4) ~= 0
            % ...concatenate the codeword index onto the sequence of symbols recovered so far
            str_decoded(idx:idx+step-1) =  dict{1,tree(node,4)};
            idx = idx + step;
        end
        % Navigate to the next node
        node = tree(node,2);
    end
end

str_decoded = str_decoded(1:idx-1);
out_file = ['decomressed_',dictionary_file_name(1:end-3),'txt'];
fileID = fopen(out_file, 'w');
fwrite(fileID,str_decoded);
fclose(fileID);

T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) DecompressFast compressed_file_name:',compressed_file_name, ' dictionary_file_name:', dictionary_file_name])
end