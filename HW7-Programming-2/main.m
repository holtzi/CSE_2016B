input = RandomMarkovGenerator('orig.bin');
encoded_data_laplace = ArithmLaplace('orig.bin');
encoded_data_arithm = ArithmAmp('orig.bin', 'ArithmAmp.bin', 'file');
encoded_data_arithm_iid = ArithmAmp('orig.bin', 'ArithmIid.bin', 'iid');
disp('end')