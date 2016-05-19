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
run('addPathToKernel');

fprintf('Projeto AM 2016-1 ... \n');
fprintf('Running sintectic samples ... \n');

%% Load an example dataset that we will be using
load('../db/ex7data2.mat');

figure(1);
scatter(X(:,1), X(:,2), 15); 

fprintf('Reading data file ... \n');

%% Calculate  Dissimilarity Matrix

% normalize vector
X = featureNormalize(X);

[n,m] = size(X);
D = zeros(n,n,2);

D(:,:,1) = dissimilarityMatrix( X );
D(:,:,2) = D(:,:,1) + 10;
D(:,:,3) = D(:,:,1) + 5;

% normalize matrix 
D = dissimilarityNormalize( D );

%% Fuzzy c-medoids vectors clustering algorithm

K = 3; m = 1.1; T = 150; e = 1e-100;
[ G, Lambda, U, J, Jt, Gt ] = MVFCMddV(D, K, m, T, e );

%% Show result

% show grups
p = 3;
previous_centroids  = X(Gt(:,p,1),:);
figure(2);clf; hold on;
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
plot(centroids(:,1), centroids(:,2), 'x', ...
     'MarkerEdgeColor','b', ...
     'MarkerSize', 10, 'LineWidth', 3);

 % show cost J
 figure(3); plot(Jt);
 title('Cost Function J(x)');
 xlabel('Iterartion');
 ylabel('Error');
 

 
 
 