function [ array_binary ] = kbits( n,k )
%GENERATE_BINARY Summary of this function goes here
%   Detailed explanation goes here
% n is number of digits
% k is sum of all digits
array_binary = [];
if (k>n)
    return 
end
if k == 0
    array_binary(1) = 0;
    return
end
matrix = perms_reps([0 1], [n-k, k]);
array_binary = zeros(1,size(matrix,1));
for i = 1:size(matrix,1)
    for j = 1:size(matrix,2)
        array_binary(i) = array_binary(i) + matrix(i,j) * 2^ ( size(matrix,2)-j) ;
    end
end

end

