%% Algorithm 2.1 k-means initialisation procedure for normal mixture models.
function [ Mu, Sigma, PI ] = emInitKm( X, g, maxiter )
% [ Mu,Sigma,PI ] = emInitKm( X, g, maxiter )
% \param X: data vector
% \param g: numero de gausianas 
% \param maxiter: maximo de iteraciones

[n,m] = size(X);

% (1) Initialisation: Pick g measurements from {x_1, ... , x_n} randomly without 
% replacement, and use these as initial values for the component mean 
% vectors {\mu_j, j = 1, ... , g}.

% i = randi(n,g,1);
i = datasample(1:n,g,'Replace', false);
Mu = X(i,:);

for t=1:maxiter
    
% (2) Iterative step:
% For i = 1, ... , n, determine \Psi_i ? {1, ... , g} such that:
% |x_i - \mu_{|Psi_i}|^2 = min_{j=1,...,g} |x_i - \mu_j|^2
% (i.e. find the closest centre to each training data vector).

psi = zeros(n,1);
for i=1:n

    xi = X(i,:); d = zeros(g,1);
    for j=1:g
    d(j) = norm(xi-Mu(j,:));     
    end
    [~,j] = min(d);
    psi(i) = j;
    
end

% If any value \Psi_i, i = 1, . . . , n, has changed from the previous 
% iteration, recalculate the component means as follows:
% \mu_j = \frac{1}{\sum_i^n I(\Psi_i == j)} \sum_i^n I(\Psi_i==j)x_i

Munew = zeros(g,m);
for j=1:g
Munew(j,:) = (1./sum(psi==j)).* sum( X(psi==j,:) );
end

% (3) If the maximum number of iterations has been exceeded then move to step 4, 
% otherwise repeat step 2.
% here

Mu = Munew;

end

% (4) Initialise the mixture component covariance matrices as follows:
% Sigma_j =  \frac{1}{\sum_i^n I(\Psi_i == j)} \sum_i^n (\psi_i == j)
%     (x_i - mu_j)(x_i - mu_j)^t

Sigma = zeros(m,m,g);
for j=1:g
xu = (X(psi==j,:) - repmat(Mu(j,:), sum(psi==j) ,1))';
Sigma(:,:,j) = (1./sum(psi==j)).*( xu*xu' );
end

% (5) Initialise the mixture component probabilities as follows:
% pi_j = 1/n sum_i^n I(psi_i == j)
PI = zeros(g,1);
for j=1:g
PI(j) = (1/n)*sum(psi==j);
end



end