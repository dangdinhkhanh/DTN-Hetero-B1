function state = value2state(M,N,value)

%M: number of messages
%N: number of nodes
%value: value need to be convert to state
%level of M
lv = ceil(log2(M))+1;

state = zeros(1,N+1);

d = floor(value/2^(N+lv));

state(1) = d;
%the rest part
r = value - d*2^(N+lv);
k = floor(r/2^N);
%the rest part
r = r-k*2^N;
%identify the current state of nodes

for j = 1:N
    state(j+1) = floor(r/2^(N-j));
    
    r = r - state(j+1)*2^(N-j);
end

end