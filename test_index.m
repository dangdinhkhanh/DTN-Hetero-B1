M = 3;
N = 4; 
%lambda = rand(N);
%lambda0 = rand(1,N); 
lambda = ones(N);
lambda0 = ones(1,N);
[A,R] = Matrix_AR(M,N,lambda,lambda0);
for i = 1: size(A,1)
    disp(sum(A(i,:))+sum(R(i,:)));
end