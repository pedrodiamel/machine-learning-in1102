function P = predictMult( model, x )
% PREDICTMULT:
% @brief p=predictMult(model, x) predic class for vector x
% @param model bayes model
% @param x object
% @return  P  posterirori probability P( w | x )
% Ecuation:
%                likelihood x prior
%   posterior = --------------------- 
%                    evidence
% 
% Precondition:
% The matrix Sigma a symmetric positive semi-definite matrix
%
% @autor: Pedro Diamel Marrero Fernandez
% @date:  27/05/2016
%

x = x(:);               % data
PI = model.prior;       % prior
mu = model.mu;          % mean \mu 
Sigma = model.Sigma;    % cavariance matrix \Sigma    
d = length(x);          % dimansion


% likelihood calculate
C = length(PI);
p = zeros(C,1); 
for i=1:C 
     
    mu_i = mu(i,:)'; 
    Sigma_i = Sigma(:,:,i);
        
    % p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
    % N(x,mu_i,sigma_i)
    p(i) = (1/(((2*pi)^(d/2))*det(Sigma_i)^0.5)) * ... 
        exp( (-1/2) * (x-mu_i)' / Sigma_i * (x-mu_i) );

end

% calculo de la probabilidad a posteriori
P = (PI.*p)/sum(PI.*p);


% % discriminant rule
% C = length(PI);
% p = zeros(C,1);
% for j=1:C
%     
%     mu_j = mu(j,:)'; Sigma_j = Sigma(:,:,j);
%     
%     % p_j = log(p(w_j)) - (1/2)log(det(Sigma_j)) - (1/2)(x-\mu_j)^tSigma_j^-1(x-\mu_j) 
%     % N(x,mu_i,sigma_i)
%     p(j) = log(PI(j)) - (1/2)*log(det(Sigma_j)) - ...
%         (1/2)*(x-mu_j)'/Sigma_j*(x-mu_j);
%     
% end
% P = p;


end

