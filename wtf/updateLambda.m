%% Equation (5)
function Lambda = updateLambda( D, G, U, K, m )

[n,nn,p] = size(D);
Lambda = zeros(K,p);

for k=1:K
for j=1:p

    num = 1; 
    for h=1:p
        d = 0;
        for i=1:n
        d = d + (U(i,k)^m)*D(i,G(k,h),h);
        end
        num = num*d;
    end
    num = num^(1/p);
        
    den = 0;
    for i=1:n
    den = den + (U(i,k)^m)*D(i,G(k,j),j);
    end
  
    Lambda(k,j) = num/(den + eps);

end
end

end

