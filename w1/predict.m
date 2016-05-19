function [w,p] = predict( x, model )

P = model.prior;
mu = model.mu;
sigma = model.sigma;

% probabilidad a posteriori
% p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
% N(x,mu_i,sigma_i)

% % Ciclo
% % N = length(P);
% % post = zeros(N,1); 
% % for i=1:N
% % post(i) = (1/((2*pi)^0.5) * sigma(i) ) * exp( -(1/2) * ((x - mu(i))/sigma(i))^2);
% % end

% % Vectorial 
post = (1/((2*pi)^0.5) .* sigma ) .* exp( -(1/2) * ((x - mu)./sigma).^2);

% calculo de la probabilidad 
p = (P.*post)/sum(P.*post);

% regla de decicion
[p, w] = max(p);

end

