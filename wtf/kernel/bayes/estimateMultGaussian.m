function [ mu, Sigma ] = estimateMultGaussian( X, W )
% @brief [mu,Sigma]=estimateMultGaussian(X,W) estimate gausian parameters
% @param X objects 
% @param W class
% @return mu vector of mean
% @return Sigma covarance matrix
% 

[~,m] = size(X);

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases

mu = zeros(C,m); Sigma = zeros(m,m,C);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = (W==i);
    Xc = X(w,:);  N = size(Xc,1);
    
    % mean vector
    mu(i,:) = (1/N) .* sum(Xc,1);
    % mu(i,:) = mean(Xc);
    

    % covariza matrix
    % Xc = bsxfun(@minus, Xc, mu(i,:));
    % Sigma(:,:,i) = (1.0/(N-1))*( Xc' * Xc );
    
    % Matlab
    Sigma(:,:,i) = cov(Xc);
    
end
end