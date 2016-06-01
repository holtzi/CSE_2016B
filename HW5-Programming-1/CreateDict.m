function [  ] = CreateDict( input_filename )
%CREATEDICT Summary of this function goes here
%   Detailed explanation goes here
CreateDictShanon(input_filename);
CreateDictHuff(input_filename,1);
CreateDictHuff(input_filename,2);
CreateDictHuff(input_filename,3);
end