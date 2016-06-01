T1 = clock;
CalculateEntropies( 'orig.txt' )
CreateDict('orig.txt')
CompressFast('orig.txt', 'dictShannon.txt')
DecompressFast('compressed_dictShannon.bin', 'dictShannon.txt')
CompressFast('orig.txt', 'dictHuffman1.txt')
DecompressFast('compressed_dictHuffman1.bin', 'dictHuffman1.txt')
CompressFast('orig.txt', 'dictHuffman2.txt')
DecompressFast('compressed_dictHuffman2.bin', 'dictHuffman2.txt')
CompressFast('orig.txt', 'dictHuffman3.txt')
DecompressFast('compressed_dictHuffman3.bin', 'dictHuffman3.txt')
T2 = clock;
DT = etime(T2,T1);
disp(['DT:', num2str(DT), '(sec) main'])