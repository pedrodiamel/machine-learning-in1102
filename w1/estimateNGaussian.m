function [ mu, Sigma ] = estimateNGaussian( X, W )


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
    %Sigma(:,:,i) = (1/n)*(X')*X;
    Sigma(:,:,i) = cov(X(w,:));

end



end

