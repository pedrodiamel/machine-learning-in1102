function y_wmv = WMV( dp, c, p, prior )
%WMV Weighted majority vote
%Imput
%dp decision profile
%c numero de clases
%p probabilidad a posteriori
%prior probabilidad a priori
%
%Output
%y_wmv estimaciion de la clase
%

[m,~] = size(dp);
y_wmv = zeros(m,1);

for i=1:m

%Ecuacion 15. [kuncheva,Juan]
%log(P(w_k|s)) prop:= log(P(w_k)) + sum_{iEI+^k}w_i + |I+^k|*log(c-1)
%Ecuacion 4.47 [kuncheva]
%g_j(x) = log(P(w_j)) + sum_{i=1}^L d_{i,j} log(p_i/(1-p_i))

g = zeros(c,1);
for j=1:c
d = (dp(i,:) == j);
g(j) = log(prior(j)) +  sum( d(:).*log(p./(1-p)) ) + sum(d)*log(c-1); 
end

[~,w] = max(g);
y_wmv(i) = w;


end




end

