

M = 2:7; 
N = 8;

num_drops = [];
drops_ratio = [];

for c = 1:length(M)

    index_array= Index_Mapping(M(c),N);
%     lambda = rand(N);
%     lambda0 = rand(1,N);
    lambda = ones(N);
    lambda0 = ones(1,N);
    
    % initial state
    state = zeros(1,N+1);
    for i = 1:M
        state(i+2) = 1;
    end
    init = Index_Searching(state2value( M(c),state ),index_array);


    [A,R] =  Matrix_AR( M(c),N,lambda, lambda0 );

    I = speye(length(index_array));
    B = (I-A)\R;


    %number of drop
    num_drop = 0;
    for i = 1:(M(c)-1)
        num_drop = num_drop+B(init,i)*(i-1);
    end
    %disp(num_drop);
    num_drops = [num_drops,num_drop];
    drop_ratio = num_drop/M(c);
    drops_ratio = [drops_ratio,drop_ratio];
end

hold on;
%plot(M,num_drops);
plot(M,drops_ratio,'bs--');
