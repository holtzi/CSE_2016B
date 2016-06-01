function [  ] = CalculateEntropies( input_filename )
%CALCULATEENTORPIES Summary of this function goes here
%   Detailed explanation goes here
[ ent1, ent_lst1, p_lst1 ,s1] = CalculateEntropiesPerSym( input_filename, 1);
[ ent2, ent_lst2, p_lst2 ,s2] = CalculateEntropiesPerSym( input_filename, 2);
[ ent3, ent_lst3, p_lst3 ,s3] = CalculateEntropiesPerSym( input_filename, 3);
fileID = fopen('entropies.txt', 'w');
fprintf(fileID,'1 %2.2f\t%2.2f\n2 %2.2f\t%2.2f\n3 %2.2f\t%2.2f',ent1,ent1,ent2,ent2/2,ent3,ent3/3);
fclose(fileID);
end