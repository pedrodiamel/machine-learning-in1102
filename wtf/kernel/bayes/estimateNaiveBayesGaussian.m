function [ mu, Sigma2 ] = estimateNaiveBayesGaussian( X, W )
% @brief [mu,Sigma]=estimateMultGaussian(X,W) estimate gausian parameters
% @param X objects 
% @param W class
% @return mu vector of mean
% @return Sigma varianza
% 

[~,m] = size(X);

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases

mu = zeros(C,m); Sigma2 = zeros(C,m);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = W==i;
    n = sum(w);
       
    %mean
    mu(i,:) = (1/n).*sum(X(w,:));
    
    %variance
    Sigma2(i,:) = (1/n)*sum((X(w,:) - repmat(mu(i,:),n,1)).^2);
     
end
end