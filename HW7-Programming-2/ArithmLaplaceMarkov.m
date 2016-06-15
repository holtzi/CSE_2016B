function [ encoded_data ] = ArithmLaplaceMarkov( input_filename, output_filename )
%ARITHMLAPLACEMARKOV Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(input_filename, 'rb');
data = fread(fileID, 'uint16');
fclose(fileID);
bin_data = dec2bin(data, 16);
bin_data_stream = reshape(bin_data', [], 1);
bin_data_nums = reshape(bin_data_stream, 2, [])';
data_input = bin2dec(bin_data_nums);
SYM = [0,1,2,3];
F = [0 0 0 0
     0 0 0 0
     0 0 0 0
     0 0 0 0];

seq = data_input;

% Encoding the Sequence of Symbols. 
L=0;U=1; % Initial Lower and Upper Intervals.
Tag_bits=zeros(1,0); % Initializing the Tag Bits.
for i=1:length(seq)
    j=find(seq(i)==SYM);   % Finds the Index of the sequence symbol in the symbol string.
    if(i>1)  
        F(seq(i-1)+1,seq(i)+1) = F(seq(i-1)+1,seq(i)+1) + 1;
    end
    A = sum(F');
    X = length(SYM);
    if(i>1)
        P = (1 + F(seq(i-1)+1,:))/(A(seq(i-1)+1) + X);
    else
        P = [0.25 0.25 0.25 0.25];
    end
    Fx = Sym_Intervals(SYM, P); 
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
   
%     while(1)
%         
%         if(U<0.5)
%             Tag_bits=[Tag_bits,'0'];
%             L=2*L;
%             U=2*U;
%         elseif (L>=0.5)
%             Tag_bits=[Tag_bits,'1'];
%             L=2*(L-0.5);
%             U=2*(U-0.5);
%         elseif((L>=0.25) &&(U<0.75))
%             L=2*(L-0.25);
%             U=2*(U-0.25);
%         else
%             break           
%         end      
%     end
    
        

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

bin_vec = reshape(encoded_data', [], 1);
bin_vec_shaped = reshape(bin_vec, 16, [])';
bin_vec = uint16(bin2dec(bin_vec_shaped));
fileID = fopen(output_filename, 'wb');
fwrite(fileID, bin_vec, 'uint16');
fclose(fileID);
end
