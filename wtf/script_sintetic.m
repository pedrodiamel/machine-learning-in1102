

%% Initialization
clear ; close all; clc


%% Load an example dataset that we will be using
load('ex7data2.mat');


% X_norm = featureNormalize(X);
X_norm = X;

[n,m] = size(X);
D = zeros(n,n,2);

D(:,:,1) = getDissimilarityMatrix( X_norm );
D(:,:,2) = D(:,:,1) + 10;
% D(:,:,3) = D(:,:,1);

K = 3; m = 1.6; T = 50; e = 1e-100;
[ G, Lambda, U, J ] = MVFCMddV( D, K, m, T, e, X );
centroids = X(G(:,1),:);

% figure;
% scatter(X(:,1), X(:,2), 15); hold on;
% plot(centroids(:,1), centroids(:,2), 'x', ...
%      'MarkerEdgeColor','k', ...
%      'MarkerSize', 10, 'LineWidth', 3);

 
 
 
 