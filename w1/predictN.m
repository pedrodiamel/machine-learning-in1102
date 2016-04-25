function [w,p] = predictN( x, model )

P = model.prior;
mu = model.mu;
Sigma = model.Sigma;
d = size(x,1);
x = x(:);

% probabilidad a posteriori
% p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
% N(x,mu_i,sigma_i)

% Ciclo
N = length(P);
post = zeros(N,1); 
for i=1:N

   
    mu_i = mu(i,:)'; Sigma_i = Sigma(:,:,i);
    invSigma = inv(Sigma_i);
    post(i) = (1/(((2*pi)^(d/2))*det(Sigma_i)^0.5)) * exp( (-1/2) * (x-mu_i)' * invSigma * (x-mu_i) );
    
    
end

% calculo de la probabilidad 
p = (P.*post)/sum(P.*post);

% regla de decicion
[p, w] = max(p);

end

