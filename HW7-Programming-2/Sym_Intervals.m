function [ Fx ] = Sym_Intervals( SYM, P )
%SYM_INTERVALS Summary of this function goes here
%   Detailed explanation goes here
    % Calculate the Symbol Intervals.
    Fx=zeros(1,length(SYM));
    for i=1:length(SYM)
        if i==1
            Fx(i)=P(i);
        else
            Fx(i)=Fx(i-1)+P(i);
        end
    end

end

