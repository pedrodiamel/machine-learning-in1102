%% Equation (5)
function Lambda = updateLambda( D, G, U, K, m )

[n,nn,p] = size(D);
Lambda = zeros(K,p);

for k=1:K
    for j=1:p
        
        Mul = 1;
        for h=1:p, Mul = Mul*sum((U(:,k).^m).*D(:,G(k,h),h)); end
        Sum = sum( (U(:,k).^m).*D(:,G(k,j),j) );      
        
        Lambda(k,j) = (Mul^(1/p))/(Sum + eps);
        
    end
end

end

