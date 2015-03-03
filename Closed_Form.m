

M = 2:9; 
N = 10;
% M = [2:4];
% N = 5;

num_drops = [];
drops_ratio = [];

rng(1);
lambda = rand(N);
rng(1);
lambda0 = rand(1,N);
for i = 1:N
    lambda(i,i) = 0;
end
for i = 1:N-1
    for j = 2:N
        lambda(j,i) = lambda(i,j);
    end
end
% lambda = ones(N);
% lambda0 = ones(1,N);

for c = 1:length(M)

    index_array= Index_Mapping(M(c),N);

    
    % initial state
    state = zeros(1,N+1);
    for i = 1:M(c)
        state(i+1) = 1;
    end
    init = Index_Searching(state2value( M(c),state ),index_array);


    [A,R] =  Matrix_AR( M(c),N,lambda, lambda0 );

    I = speye(length(index_array));
    B = (I-A)\R;


    %number of drop
    num_drop = 0;
    for i = 1:M(c)
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
