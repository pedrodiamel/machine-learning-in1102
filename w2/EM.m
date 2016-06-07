%% EM-algorithm
function [Mu,Sigma,PI] = EM( X, g, maxiter )
% [Mu,Sigma,PI] = EM( X, g, maxiter )
% Algorithm 2.2 Iterative EM procedure for normal mixture models.
% Suppose that at the end of iteration m ? 0 we have the following 
% parameter estimates:
% PI_j^m, mu_j^m, Sigma_j^m 
% (iteration 0 corresponds to the initialisation stage). The (m+1)th 
% iteration of theEMalgorithm is then as follows:
%
% \param X: data vector
% \param g: numero de gausianas 
% \param maxiter maximo de iteraciones
%

[n,m] = size(X);

%% Initialization 
% Algorithm 2.1 k-means initialisation procedure for normal mixture models.
[ Mu, Sigma, PI ] = emInitKm( X, g, 10 );


%% EM
for t=1:maxiter


%% E-Step

w = zeros(n,g);
for i=1:n
    PX = 0;
    for j=1:g
        p = PI(j)*normdist( X(i,:)', Mu(j,:)', Sigma(:,:,j) );
        w(i,j) = p;
        PX = PX + p;
    end
    w(i,:) = w(i,:)./PX;    
end

%% M-Step

PInew = zeros(g,1);
Munew = zeros(g,m);
Sigmanew = zeros(m,m,g);
for j=1:g
    
    PInew(j) = (1/n)*sum(w(:,j));
       
    for i=1:n
        Munew(j,:) = Munew(j,:) + ...
            (w(i,j).*X(i,:));
    end
    Munew(j,:) = (1/(n*PInew(j))).*Munew(j,:);
    
    for i=1:n
        Sigmanew(:,:,j) = Sigmanew(:,:,j) + ...
            w(i,j).*(X(i,:)-Munew(j,:))'*(X(i,:)-Munew(j,:));
    end
    Sigmanew(:,:,j) = (1/(n*PInew(j))).*Sigmanew(:,:,j);
    
end

PI = PInew;
Mu = Munew;
Sigma = Sigmanew;

end
end