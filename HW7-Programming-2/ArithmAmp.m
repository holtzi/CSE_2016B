function [ encoded_data ] = ArithmAmp( input_filename, output_filename, mode)
%ARITHMAMP Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(input_filename, 'rb');
data = fread(fileID, 'uint16');
fclose(fileID);
bin_data = dec2bin(data, 16);
bin_data_stream = reshape(bin_data', [], 1);
bin_data_nums = reshape(bin_data_stream, 2, [])';
data_input = bin2dec(bin_data_nums);
SYM = [0,1,2,3];
if (strcmp(mode,'iid'))
    P = [1/4, 1/4, 1/4, 1/4];
else
    P = EmpiricProb(data_input);
end

if(length(SYM)==length(P) && sum(P)==1)  
    %% ALGORITHM IMPLEMENTATION
    seq = data_input;
    Fx = Sym_Intervals(SYM, P);
    
    % Encoding the Sequence of Symbols. 
    L=0;U=1; % Initial Lower and Upper Intervals.
    Tag_bits=zeros(1,0); % Initializing the Tag Bits.
    for i=1:length(seq)
        j=find(seq(i)==SYM);   % Finds the Index of the sequence symbol in the symbol string.
        if(j==1)
            L_new=L;
        else
            L_new=L+(U-L)*Fx(j-1);
        end
        U_new=L+(U-L)*Fx(j);
        L=L_new;
        U=U_new;
        while((L<0.5 && U<0.5) ||(L>=0.5 && U>0.5))
            if(L<0.5 && U<0.5)
                Tag_bits=[Tag_bits,'0'];
                L=2*L;
                U=2*U;
            else
                Tag_bits=[Tag_bits,'1'];
                L=2*(L-0.5);
                U=2*(U-0.5);
            end
        end
        
    end
    tag=(L+U)/2;
    
    % Embedding the Final Tag Value.
    bits=zeros(1,0);
    if(2*tag>1)
        tag=2*tag-1;
        bits=[bits,'1'];
    else
        tag=2*tag;
        bits=[bits,'0'];
    end
    
    while(bin2dec(bits)/2^length(bits)<L)
        if(2*tag>1)
            tag=2*tag-1;
            bits=[bits,'1'];
        else
            tag=2*tag;
            bits=[bits,'0'];
        end
    end
    Tag_bits=[Tag_bits,bits];
    
    % Padding of zeros is done to keep the TAG BITS size multiple of 16 bits.
    Tag_bits=[Tag_bits,dec2bin(0,16-rem(length(Tag_bits),16))];
    encoded_data = Tag_bits;
else
    display('Plese enter proper values!!!');
end
bin_vec = reshape(encoded_data', [], 1);
bin_vec_shaped = reshape(bin_vec, 16, [])';
bin_vec = uint16(bin2dec(bin_vec_shaped));
fileID = fopen(output_filename, 'wb');
fwrite(fileID, bin_vec, 'uint16');
fclose(fileID);
end