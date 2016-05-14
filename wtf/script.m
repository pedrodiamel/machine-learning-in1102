%% Projeto AM 2016-1
% =========================================================================
% Exercise (1)
% Considere os dados "multiple features" do site uci machine learning 
% repository (http://archive.ics.uci.edu/ml/).
%
% a) Compute 3 matrizes de dissimilaridade (um para cada tabela de dados
%    mfeat-fac, mfeat-fou, mfeat-kar) usando a distancia Euclidiana.
% b) Execute o algoritmo "Multi-view relacional fuzzy c-medoids vectors
%    clustering algorithm - MVFCMddV" simultaneamente nessas 6 matrizes de
%    dissimilaridade 100 vezes para obter uma partição fuzzy em 10 grupos e
%    selecione o melhor resultado segundo a função objetivo. Para detalhes 
%    do algoritmo "Multi-view relacional fuzzy c-medoids vectors clustering
%    algorithm - MVFCMddV" veja a seção 2 do artigo:
%    [1] de Carvalho, F. D. A., de Melo, F. M., & Lechevallier, Y. (2015). 
%    A multi-view relational fuzzy c-medoid vectors clustering algorithm. 
%    Neurocomputing, 163, 115-123.
%
% -------------------------------------------------------------------------
% Observações:
% -------------------------------------------------------------------------
% - Parametros: K = 10; m = 1.6; T = 150; eps = 1e-10
% - Para o melhor resultado imprimir: i) a partição fuzzy (matrix U), ii) a 
%   matriz de pesos iii) a partição hard (para cada grupo, a lista de 
%   objetos), vi) para cada grupo a lista de medoids, v) 0 índice de Rand 
%   corrigido.
%

%% Initialization
clear ; close all; clc

%% Load data

n = 100;
X1 = load('db/mfeatfac.mat','X'); X1 = X1.X(1:n,:);
X2 = load('db/mfeatfou.mat','X'); X2 = X2.X(1:n,:);
X3 = load('db/mfeatkar.mat','X'); X3 = X3.X(1:n,:);

% normalize vector
X1 = featureNormalize(X1);
X2 = featureNormalize(X2);
X3 = featureNormalize(X3);


%% Calculate  Dissimilarity Matrix

D = zeros(n,n,3);
D(:,:,1) = dissimilarityMatrix( X1 );
D(:,:,2) = dissimilarityMatrix( X2 );
D(:,:,3) = dissimilarityMatrix( X3 );

% normalize matrix 
D = dissimilarityNormalize( D );

%% Fuzzy c-medoids vectors clustering algorithm

K = 3; m = 1.6; T = 150; e = 1e-100;
[ G, Lambda, U, J, Gt ] = MVFCMddV( D, K, m, T, e );


%% Show result
X = X1(:,1:2);p = 1;
previous_centroids  = X(Gt(:,p,1),:);
figure(1);clf; hold on;
for i=1:size(G,1)
centroids = X(Gt(:,p,i),:);
plot(X(:,1), X(:,2),'or'); 
plot(centroids(:,1), centroids(:,2), 'x', ...
    'MarkerEdgeColor','k', ...
    'MarkerSize', 10, 'LineWidth', 3);
for j=1:size(centroids,1)
    drawLine(centroids(j, :), previous_centroids(j, :));
end
previous_centroids = centroids;
drawnow;
% pause;
end

centroids = X(G(:,1),:);
figure(1); hold on;
% scatter(X(:,1), X(:,2), 15); 
plot(centroids(:,1), centroids(:,2), 'x', ...
     'MarkerEdgeColor','b', ...
     'MarkerSize', 10, 'LineWidth', 3);


