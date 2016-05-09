%% MVFCMddV
function [ G, Lambda, U, J ] = MVFCMddV( D, K, m, T, e, X )
%[G,Lambda,U]=MVFCMddV(D,K,m,T,e) Multi-view relational fuzzy c-medoid 
% vectors clustering algorithm
%   
% INPUT
% \param D_nxnxp matrices de disimililaridad. D_j[i,l] = d_j(e_i,e_l)
% \param K numbers of cluster (2<=K<n)
% \param m parameter (1<m<oo)
% \param T iteration limit
% \param e epsilom
% 
% OUTPUT
% \return G_kxp
% \return Lambda_kxp
% \return U_nxk
%
% de Carvalho, F. D. A., de Melo, F. M., & Lechevallier, Y. (2015). 
% A multi-view relational fuzzy c-medoid vectors clustering algorithm. 
% Neurocomputing, 163, 115-123.

[n,nn,p] = size(D);

%% INITIALIZATION

% randomly select _K_ distinct medoid vectors
G = zeros(K,p);
for j=1:p
k = datasample(1:n,K,'Replace', false);
G(:,j) = k(:); 
end

% the dissimilarity matrices have the same relevance weight
Lambda = ones(n,p);

% For each object e_i(i=1,…,n) compute the component u_{ik}^t according 
% to Eq (6) to obtain the vector of membership degree vectors U^t.
U = updateU(D,G,Lambda,K,m);

% From v_t = (G^t,Lambda^t,U^t) compute u_t = J(v_t) according to Eq 1.
J = zeros(T,1);
J(1) = costFunction(D,G,Lambda,U,K,m);

%%%%
previous_centroids  = X(G(:,1),:);
%%%%

%% REPEAT
for t=1:T

    % Output progress
    fprintf('MVFCMddV iteration %d/%d - J=%d...\n', t, T, J(t));
    
    % Step 1: Search for the Best Medoid Vectors
    Gt = updateCluster( D, U, K, m );
    
    % Step 2: Computation of the Best Vectors of Relevance Weights
    Lambdat = updateLambda( D, Gt, U, K, m );
    
    % Step 3: Computation of the Best Fuzzy Partition
    Ut = updateU(D,Gt,Lambdat,K,m);
    
    J(t+1) = costFunction(D,Gt,Lambdat,Ut,K,m);
    if abs(J(t+1) - J(t)) < e
        break;
    end

    G = Gt; Lambda = Lambdat; U = Ut;
    
    %%%%%
    figure(1);
    centroids = X(G(:,1),:);
    plot(X(:,1), X(:,2),'or'); hold on;
    plot(centroids(:,1), centroids(:,2), 'x', ...
     'MarkerEdgeColor','k', ...
     'MarkerSize', 10, 'LineWidth', 3);
    for j=1:size(centroids,1)
    drawLine(centroids(j, :), previous_centroids(j, :));
    end
    previous_centroids = centroids;
    drawnow;
    %%%%%
    
end

J = J(1:t);


end