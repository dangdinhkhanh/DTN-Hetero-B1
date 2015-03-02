function [ index_array ] = Index_Mapping( M,N )
%INDEX_MAPPING Summary of this function goes here
%   Detailed explanation goes here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% M: number of messages need to be delivered to a destination
% N: Number of nodes (not destination) in the network
% state (x1,x2,...,xN,d) where x_i ={0,1}, 0<=d<=M-1 and sum(x_i)+d<=M

% index is assigned for state
i = 1;
% identify level of M
lv = ceil(log2(M))+1;
% the number of drops
for d=0:(M-1)
    for k = 1: (M-d)
        array_binary = kbits(N,k);
        for j = 1:length(array_binary)
            index_array(i) = d* 2^(N+lv) + k*2^N + array_binary(j);
            disp(sprintf('index %d',i));
            disp(value2state(M,N,index_array(i)));
            i = i+ 1;
        end
    end

end


end

