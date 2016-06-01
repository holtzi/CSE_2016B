function [ ent, ent_lst, p_lst ,s] = CalculateEntropiesPerSym( input_filename, sym_len)
%CalculateEntorpies Summary of this function goes here
%   Detailed explanation goes here
T1 = clock;
input_array = fileread(input_filename);
abc = cell(26);
for n1 = 1:26
    abc{n1} = char('a' + (n1-1));
end
i=1;
symbol = cell(26^sym_len);
for n1 = 1:26
    if sym_len == 1
        symbol{i} = [abc{n1}];
        i=i+1;
    else
    for n2 = 1:26
        if sym_len == 2
            symbol{i} = [abc{n1} ,abc{n2}];
            i=i+1;
        else
        for n3 = 1:26
            symbol{i} = [abc{n1} ,abc{n2}, abc{n3}];
            i=i+1;
        end
        end
    end
    end
end
i = i-1;
s = struct();
for index = 1:i
    s = setfield(s, symbol{index}, 0);
end
fn = fieldnames(s);
total_len = length(input_array) / sym_len;

for n = 1:sym_len:length(input_array)
   % character = input_array(n:n + sym_len - 1);
    s.(input_array(n:n + sym_len - 1)) = s.(input_array(n:n + sym_len - 1)) + 1;
end

ent_lst = zeros(1,length(fn));
p_lst=zeros(1,length(fn));
for fn_index = 1:length(fn);
    letter = fn(fn_index);
    letter_iter = getfield(s, letter{1});
    p = letter_iter / total_len;
    p_lst(fn_index) =  p;
    if p ~= 0
        ent_lst(fn_index) =  -p*log2(p);
    else
        ent_lst(fn_index) = 0;
    end
end
ent = sum(ent_lst);
T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) CalculateEntropiesPerSym input_filename:',input_filename, ' sym_len:', num2str(sym_len)])