function [w,p] = predictAll( x, model )
% @brief [w,p]=predictAll(X,model) predic class for vector x
% @param x object
% @param model bayes model
% @return  w class hard
% @return  p  max posterirori probability  max_i P( w_i | x)

x = x(:);
PI = model.prior;
mu = model.mu; Sigma = model.Sigma;
d = length(x);


% probabilidad a posteriori
% p( w_i | x ) = \frac{ p(w_i)*N(x,mu_i,sigma_i) }{ sum(p(w_i)*N(x,mu_i,sigma_i))}
% N(x,mu_i,sigma_i)

C = length(PI);
post = zeros(C,1); 
for i=1:C
 
    mu_i = mu(i,:)'; Sigma_i = Sigma(:,:,i); 
    post(i) = (1/(((2*pi)^(d/2))*det(Sigma_i)^0.5)) * exp( (-1/2) * (x-mu_i)' / Sigma_i * (x-mu_i) );    
        
end

% calculo de la probabilidad 
p = (PI.*post)/sum(PI.*post);

% max ruler
% p( w | x ) = max_i p( w_i | x)
[p, w] = max(p);

end

