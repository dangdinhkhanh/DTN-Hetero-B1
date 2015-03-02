function [ value ] = state2value( M,state )
%STATE2VALUE Summary of this function goes here
%   Detailed explanation goes here
% M: number of messages
lv = ceil(log2(M))+1;
k = sum(state(2:end));
d = state(1);
N = length(state)-1;
value = d*2^(N+lv)+k*2^N;
for i = 2:(N+1)
    value = value + state(i)*2^(N+1-i);
end

end

