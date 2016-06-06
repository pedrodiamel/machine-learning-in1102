%% Equation (6)
function U = updateU( D, G, Lambda, K, m )
% Equation (6)
% u_{i,k}^t = [ \sum_h^K(\frac{d_Lambda_k^t(e_i,g_k^t),d_Lambda_h^t(e_i,g_h^t)})^(1/(m-1))]^-1 
% i=1,...,n; k=1,...,K.

[n,~,p] = size(D);
U = zeros(n,K);
for i=1:n
    for k=1:K        
        
        for h=1:K
            num = 0; den = 0;
            for j=1:p
                num = num + Lambda(k,j) * D(i,G(k,j),j);
                den = den + Lambda(h,j) * D(i,G(h,j),j);
            end        
            U(i,k) = U(i,k) + (( num / ( den + eps ))^(1/(m-1)));
        end        
        U(i,k) = 1 / ( U(i,k) + eps );
        
    end
end
end







