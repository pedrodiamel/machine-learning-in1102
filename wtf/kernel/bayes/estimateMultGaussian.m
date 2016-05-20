function [ mu, Sigma ] = estimateMultGaussian( X, W )
% @brief [mu,Sigma]=estimateMultGaussian(X,W) estimate gausian parameters
% @param X objects 
% @param W class
% @return mu vector of mean
% @return Sigma covarance matrix
% 

[n,m] = size(X);

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases

mu = zeros(C,m); Sigma = zeros(m,m,C);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = W==i;
        
    % mean
    mu(i,:) = mean(X(w,:),1);

    % standar desviation
    Sigma(:,:,i) = (1/(n-1))*(X')*X;
    %Sigma(:,:,i) = cov(X(w,:));

end
end