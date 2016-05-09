%% Ecuation (4)
function G = updateCluster( D, U, K, m )
% \sum_i^n (u_{ik})d_j(e_i,g_j)-> Min
% l = \arg_{1<h<n}  \sum_i^n (u_{ik})d_j(e_i,e_h)

[n,nn,p] = size(D);
G = zeros(K,p);
for k=1:K
for j=1:p
    cost = zeros(n,1);
    for h=1:n
    cost(h) = sum( (U(:,k).^m).*D(:,h,j)); 
    end    
    [cost,l] = min(cost);
    G(k,j) = l;
end
end
end