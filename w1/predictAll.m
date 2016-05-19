function [w,p] = predictAll( x, model )


x = x(:);
PI = model.prior;
mu = model.mu;
Sigma = model.Sigma;
d = length(x);


% probabilidad a posteriori
% p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
% N(x,mu_i,sigma_i)

% Ciclo
N = length(PI);
post = zeros(N,1); 
for i=1:N
 
    mu_i = mu(i,:)'; 
	Sigma_i = Sigma(:,:,i); 
    post(i) = (1/(((2*pi)^(d/2))*det(Sigma_i)^0.5)) * exp( (-1/2) * (x-mu_i)' / invSigma * (x-mu_i) );
        
end

% calculo de la probabilidad 
p = (PI.*post)/sum(PI.*post);

% regla de decicion
[p, w] = max(p);

end

