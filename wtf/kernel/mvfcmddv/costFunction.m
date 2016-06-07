function J = costFunction( D,G,Lambda,U,K,m )
% Equation (1)
% J(G,Lambda,U) = \sum_k \sum_i (u_{ik}^m d_lambda_k(e_i,g_k))

% J = 0;
[n,~,p] = size(D);

% % for k=1:K
% %     for i=1:n       
% %         Sum = 0;    
% %         for j=1:p, Sum = Sum + Lambda(k,j)*D(i,G(k,j),j); end        
% %         J = J + (U(i,k)^m) * Sum;
% %     end
% % end

[k,i,j] = meshgrid(1:K,1:n,1:p);i=i(:); j=j(:); k = k(:);
J = sum( (U((k-1).*n + i).^m).* Lambda((j-1).*K + k).*D((j-1).*(n*n) + ... 
    ((G((j-1).*K + k)-1).*n)  + i ));



end