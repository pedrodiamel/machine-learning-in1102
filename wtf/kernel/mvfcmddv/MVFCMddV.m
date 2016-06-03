%% MVFCMddV
function [ G, Lambda, U, J, Js, Gs ] = MVFCMddV( D, K, m, T, e )
%[G,Lambda,U]=MVFCMddV(D,K,m,T,e) Multi-view relational fuzzy c-medoid 
% vectors clustering algorithm
% 
% @param D_nxnxp matrices de disimililaridad. D_j[i,l] = d_j(e_i,e_l)
% @param K numbers of cluster (2<=K<n)
% @param m parameter (1<m<oo)
% @param T iteration limit
% @param e epsilom 
% @return G_kxp
% @return Lambda_kxp
% @return U_nxk
%
% @ref de Carvalho, F. D. A., de Melo, F. M., & Lechevallier, Y. (2015). 
% A multi-view relational fuzzy c-medoid vectors clustering algorithm. 
% Neurocomputing, 163, 115-123.
%
% @autor Pedro Marrero Fernardez
% @date  14/05/2016
%
% @Example
% K = 3; m = 1.1; T = 150; e = 1e-100;
% [ G, Lambda, U, J, Jt, Gt ] = MVFCMddV(D, K, m, T, e );
% 

%% INITIALIZATION

[n,~,p] = size(D);

% randomly select _K_ distinct medoid vectors
G = zeros(K,p);
for j=1:p
    k = datasample(1:n,K,'Replace', false);
    G(:,j) = k(:); 
end
Gs = zeros(K,p,T+1);
Gs(:,:,1) = G;

% the dissimilarity matrices have the same relevance weight
Lambda = ones(K,p);

% For each object e_i(i=1,�,n) compute the component u_{ik}^t according 
% to Eq (6) to obtain the vector of membership degree vectors U^t.
U = updateU(D,G,Lambda,K,m);

% From v_t = (G^t,Lambda^t,U^t) compute u_t = J(v_t) according to Eq 1.
J = zeros(T+1,1);
J(1) = costFunction(D,G,Lambda,U,K,m);


%% REPEAT
for t=1:T

    % Output progress
    fprintf('MVFCMddV iteration %d/%d - J=%d...\n', t, T, J(t));
    
    % Step 1: Search for the Best Medoid Vectors
    % Ecuation (4)
    G = updateCluster( D, U, K, m );
    
    % Step 2: Computation of the Best Vectors of Relevance Weights
    % Ecuation (5)
    Lambda = updateLambda( D, G, U, K, m );
    
    % Step 3: Computation of the Best Fuzzy Partition
    % Ecuation (6)
    U = updateU(D,G,Lambda,K,m);
    
    % Update
    Gs(:,:,t+1) = G;
    
    
    % Stop condition 
    % Ecuation (1)
    J(t+1) = costFunction(D,G,Lambda,U,K,m);
    if abs(J(t+1) - J(t)) < e, break; end

    
end

% Create output
Js = J(1:t+1);
Gs = Gs(:,:,1:t+1);
J  = Js(t+1);


end