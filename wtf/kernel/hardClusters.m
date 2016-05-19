function Q = hardClusters( U  )
%Q=hardClusters(U) get hard clusters 
%   Detailed explanation goes here

% [~, Q] = max(U,[],2);

[n,c] = size(U);

% Q = {Q_1, Q_2, ... Q_c}
% Q_i = { e_k : u_{i,k} > u_{m,k} ; m \in {1, ... , c}}

Q = zeros(n,c);
for i=1:c
    for k=1:n
        
        if all((U(k,i) - U(k,:)) < eps);        
        Q(k,i) = 1;
        end
        
    end
end

end