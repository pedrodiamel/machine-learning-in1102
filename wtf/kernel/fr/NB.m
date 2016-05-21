function y_nb = NB( dp, c, p, prior )
%NB Naive Bayes combiner
%Imput
%dp decision profile
%c numero de clases
%p probabilidad a posteriori
%prior probabilidad a priori
%
%Output
%y_nb estimacion de la clase
%

[M,L] = size(dp);
y_nb = zeros(M,1);


for i=1:M

%Ecuacion 20. (pag. 6) [kuncheva, Juan]
% log(P(w_k|s)) prop:= log(P(w_k)) + sum_{i=1}^{L} log(p_{i,s_i,k}) 

u = zeros(c,1);
for j=1:c

    
    si = dp(i,:); si = si(:);
    k = j*ones(L,1);
    pijk = zeros(L,1);
    for l=1:L
    pijk(l) = p(k(l),si(l),l); 
    end
    
    %Kuncheva and Juan
    u(j) = log(prior(j)) + sum( log(pijk) );
    
%     %Kuncheva
%     Nk = sum(double(y==j)); 
%     u(j) = (Nk/M)*(prod((pijk + 1/C)/(Nk+1)));

    
end

[~,w] = max(u);
y_nb(i) = w;

end
end