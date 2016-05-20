function [w,p] = predictMult( x, model )
% @brief [w,p]=predictMult(X,model) predic class for vector x
% @param x object
% @param model bayes model
% @return  w class hard
% @return  p  max posterirori probability  max_i P( w_i | x)
% Precondition:
% Sigma a symmetric positive semi-definite matrix
%

x = x(:);
PI = model.prior;
mu = model.mu; Sigma = model.Sigma;
d = length(x); % dimencion de la data


% probabilidad a posteriori
% % C = length(PI);
% % post = zeros(C,1); 
% % for i=1:C 
% %      
% %     mu_i = mu(i,:)'; Sigma_i = Sigma(:,:,i);
% %     
% %     % p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
% %     % N(x,mu_i,sigma_i)
% %     post(i) = (1/(((2*pi)^(d/2))*det(Sigma_i)^0.5)) * exp( (-1/2) * (x-mu_i)' / Sigma_i * (x-mu_i) );
% % 
% % end
% % 
% % % calculo de la probabilidad 
% % p = (PI.*post)/sum(PI.*post);

% discriminant rule
C = length(PI);
p = zeros(C,1);
for j=1:C
    
    mu_j = mu(j,:)'; Sigma_j = Sigma(:,:,j);
    
    % p_j = log(p(w_j)) - (1/2)log(det(Sigma_j)) - (1/2)(x-\mu_j)^tSigma_j^-1(x-\mu_j) 
    % N(x,mu_i,sigma_i)
    p(j) = log(PI(j)) - (1/2)*log(det(Sigma_j)) - ...
        (1/2)*(x-mu_j)'/Sigma_j*(x-mu_j);
    
end

% max ruler
% p( w | x ) = max_i p( w_i | x)
[p, w] = max(p);

end

