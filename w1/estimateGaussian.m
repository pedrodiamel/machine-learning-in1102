function [mu, sigma] = estimateGaussian( X, W )

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases

mu = zeros(C,1); sigma = zeros(C,1);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = W==i;
    mu(i) = mean(X(w));
    sigma(i) = std(X(w));    

end

end

