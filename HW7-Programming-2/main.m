input = RandomMarkovGenerator('orig.bin');
encoded_data_laplace = ArithmLaplace('orig.bin');
len_laplace = length(encoded_data_laplace)
encoded_data_arithm = ArithmAmp('orig.bin', 'ArithmAmp.bin', 'file');
aa = hist(double(input));
code= dec2bin(arithenco(double(input+1),[aa(1) aa(4) aa(7) aa(10)]));
l1 = length(code)
eq1 = isequal(code(1:1e6)',encoded_data_arithm(1:1e6))
len_apriori = length(encoded_data_arithm)
encoded_data_arithm_iid = ArithmAmp('orig.bin', 'ArithmIid.bin', 'iid');
code2= dec2bin(arithenco(double(input+1),[250000 250000 250000 250000]));
l2 = length(code2)
eq2 = isequal(code2(1:1e6)',encoded_data_arithm_iid(1:1e6))
len_iid = length(encoded_data_arithm_iid)
encoded_data_arithm_lap = ArithmLaplaceMarkov('orig.bin', 'ArithmLapMarkov.bin');
len_markov = length(encoded_data_arithm_lap)
disp('end')
