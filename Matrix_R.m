function [ R ] = Matrix_R( M,N, lambda0 )
    %MATRIX_R Summary of this function goes here
    %   Detailed explanation goes here

    % R: matrix R (from normal state i to absorbing state j)
    % M: number of messages
    % N: number of nodes
    index_array = Index_Mapping(M);
    n = length(index_array);
    % number of columns is M  where posibilitis of drops belongs (0,1,...,M-1) 

    % create a matrix R of zeros
    R = zeros(n,M);

    for d = 0:(M-1)
        for i = 1:N
            % from state (d,0,0,...,1 (i_th pos),..,0,0) to state
            % (d,0,0,...,0,0) with transition rate lambda_i
            state = zeros(1,N+1);
            state(1) = d; 
            state(i+1) = 1;
            value = state2value(M, state);
            index = Index_Searching(value, index_array);
            
        end

    

    end

end

