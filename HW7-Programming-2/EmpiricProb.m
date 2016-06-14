function [ P ] = EmpiricProb( input_data )
%EMPIRICPROB Summary of this function goes here
%   Detailed explanation goes here
Appearance = [0, 0, 0, 0];
for i=1:length(input_data);
    s = input_data(i);
    Appearance(s + 1) = Appearance(s + 1) + 1;
end
P = Appearance / sum(Appearance);
end