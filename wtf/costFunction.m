function J = costFunction( D,G,Lambda,U,K,m )
% Equation (1)
% J(G,Lambda,U) = \sum_k \sum_i (u_{ik}^m d_lambda_k(e_i,g_k))

J = 0;
[n,nn,p] = size(D);
for k=1:K
    for i=1:n       
        d = 0;    
        for j=1:p
        d = d + Lambda(k,j)*D(i,G(k,j),j);
        end        
        J = J + (U(i,k)^m)*d;
    end
end
end