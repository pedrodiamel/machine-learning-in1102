function y_rec = REC( dp, c, p, prior )
%REC Recall combiner
%Imput
%dp decision profile
%c numero de clases
%p probabilidad a posteriori
%prior probabilidad a priori
%
%Output
%y_rec estimaciion de la clase
%


[m,~] = size(dp);
y_rec = zeros(m,1);

for i=1:m

%Ecuacion 19. [kuncheva,Juan]
%log(P(w_k|s)) prop:= log(P(w_k)) + sum_{i=1}^L(log(1 - p_{i,k})) + sum_{iEI+^k}(w_i) + |I+^k|*log(c-1)

g = zeros(c,1);
for j=1:c
d = (dp(i,:) == j);
g(j) = log(prior(j)) + sum(log(1-p(j,:))) ...
    + sum( d.*log(p(j,:)./(1-p(j,:))) ) + sum(d)*log(c-1);  
end

[~,w] = max(g);
y_rec(i) = w;


end




end

