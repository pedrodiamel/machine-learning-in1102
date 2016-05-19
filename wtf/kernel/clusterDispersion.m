function T = clusterDispersion(D,Lambda, U, K )
%T = clusterDispersion( G,Lamnda, U ): Calculate de cluster dispersion 
%   Detailed explanation goes here

[n,~,p] = size(D);

% calculate the global medoid vector
% Ecuation (8)

g = zeros(1,p);
for j=1:p
    Sum = zeros(n,1);
    for h=1:n, Sum(h) = sum( D(:,h,j) );  end
    [~,l] = min(Sum);
    g(j) = l;      
end

% cluster dispersion
% Ecuation (7)

T = zeros(K,1);
for k=1:K
   for i=1:n   
       d=0;
       for j=1:p, d = d + Lambda(k,j)*D(i,g(j),j); end
       T(k) = T(k) + (U(i,k)^m)*d;   
   end
end


end

