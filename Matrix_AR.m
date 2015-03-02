function [ A,R ] = Matrix_AR( M,N,lambda,lambda0 )
%MATRIX_A Summary of this function goes here
%   Detailed explanation goes here
% A: matrix A
% M: number of messages
% N: number of nodes
% lambda: symmatric matrix N*N of transition rates
% lambda0: vector of transition rate from nodes to the destination
    index_array = Index_Mapping(M,N);
    % size of matrix A
    n = length(index_array);
    %A = zeros(n);
    A = sparse(n,n);
    %matrix of transitional rates 
    rate = sparse(n,n);
    lv = ceil(log2(M))+1;
    for i = 1:n
       %convert A(i) to the state of network
       state = value2state(M,N,index_array(i));
       d = state(1);
       % find index of nodes that have messages
       position1 = [];
       % find index of nodes that do not have messages
       position0 =[];
       for j = 2:(N+1)
            if state(j)==1
                position1 = [position1,j-1];
            else
                position0 = [position0,j-1];
            end
       end
       % transitional states
       % no loss, no deliver
       for j = 1:length(position1)
            for k = 1: length(position0)
                %new state
                new_state = state();
                new_state(position1(j)+1)=0;
                new_state(position0(k)+1)=1;
                %disp(new_state);
                new_value = state2value(M,new_state);
                new_index = Index_Searching(new_value,index_array);
                %disp(sprintf('new_index %d',new_index));
                rate(i,new_index) = lambda(position1(j),position0(k));
            end
       end
       
       if sum(state(2:end))>=2
       % deliver
            for j = 1:length(position1)
                new_state = state;
                new_state(position1(j)+1)=0;
                new_value = state2value(M,new_state);
                new_index = Index_Searching(new_value,index_array);
                rate(i,new_index) = lambda0(position1(j));
            end

       % lose 1 message
 
            for j = 1:(length(position1)-1)
                for k = (j+1):length(position1)
                    new_state = state;
                    new_state(1) = d+1;
                    new_state(position1(j)+1)=0;

                    new_value = state2value(M,new_state);

                    new_index = Index_Searching(new_value,index_array);
                    rate(i,new_index) = lambda(position1(j),position1(k))/2;

                    new_state = state;
                    new_state(1) = d+1;
                    new_state(position1(k)+1)=0;
                    new_value = state2value(M,new_state);
                    new_index = Index_Searching(new_value,index_array);
                    rate(i,new_index) = lambda(position1(j),position1(k))/2;
                end
            end

       end
    end
   
    s = [];
    for i = 1:n
        s(i) = sum(rate(i,:));
    end
    % matrix R
     
    R = zeros(n,M);
    
    % adding absorbing rate
    for d = 0:(M-1)
        for i = 1:N
            % from state (d,0,0,...,1 (i_th pos),..,0,0) to state
            % (d,0,0,...,0,0) with transition rate lambda_i
            state = zeros(1,N+1);
            state(1) = d; 
            state(i+1) = 1;
            value = state2value(M, state);
            index = Index_Searching(value, index_array);
            s(index) = s(index) + lambda0(i);
            R(index,d+1) = lambda0(i)/s(index);
        end
    end
    %normalize matrix r to make matrix A
    for i = 1:n
        for j = 1:n
            A(i,j) = rate(i,j)/s(i);
        end
    end
end
