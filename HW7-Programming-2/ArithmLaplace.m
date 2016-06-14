function [ encoded_data ] = ArithmLaplace( input_filename )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(input_filename, 'rb');
data = fread(fileID, 'uint16');
fclose(fileID);
bin_data = dec2bin(data, 16);
bin_data_stream = reshape(bin_data', [], 1);
bin_data_nums = reshape(bin_data_stream, 2, [])';
data_input = bin2dec(bin_data_nums);
SYM = [0,1,2,3];
Appearance = [1, 1, 1, 1];
P = Appearance / sum(Appearance);
disp('ArithmLaplace SYM [0,1,2,3] Probabilities')
fprintf('%1.2f %1.4f %1.4f %1.4f %1.4f\n' , 0, P(1), P(2), P(3), P(4))


if(length(SYM)==length(P) && sum(P)==1)  
    %% ALGORITHM IMPLEMENTATION
    seq = data_input;
    
    % Encoding the Sequence of Symbols. 
    L=0;U=1; % Initial Lower and Upper Intervals.
    Tag_bits=zeros(1,0); % Initializing the Tag Bits.
    for i=1:length(seq)
        P = Appearance / sum(Appearance);
        Fx = Sym_Intervals(SYM, P);
        j=find(seq(i)==SYM);   % Finds the Index of the sequence symbol in the symbol string.
        Appearance(j) = Appearance(j) + 1;
        len = length(seq) / 4;
        if i == len || i == 2*len || i==3*len || i==4*len
            pers = i/length(seq);
            str =  sprintf('%1.2f %1.4f %1.4f %1.4f %1.4f' , pers, P(1), P(2), P(3), P(4));
            disp(str)
        end
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
end