%% PROJETO AM 2016-1
% =========================================================================
% Exercise (1)
% Considere os dados "multiple features" do site uci machine learning 
% repository (http://archive.ics.uci.edu/ml/).
%
% *) Generate sintatic date for test.
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
fprintf('Reading data file ... \n');

% load data from file
% load('../db/st-data2.mat');

rng(1); % for reproducibility

size_sample = 150;
[X,Y] = generateRandNormData( size_sample );
[n,~] = size(X);

% normalize vector
X1 = featureNormalize(X);
X2 = X1*[cos(30) -sin(30); sin(30) cos(30)];
X3 = X1*[cos(90) -sin(90); sin(90) cos(90)];
X  = cat(3,X1,X2,X3); 
p = 3;


% show data 
str = {'0' '30' '90'};
figure(1);
for i=1:p
subplot(1,p,i); scatter(X(:,1,i), X(:,2,i), 15); 
xlabel('X'); ylabel('Y'); 
title(['XY: \theta = ' str{i}])
box on;
set(gca, 'XGrid','on','YGrid','on');
end


%% Calculate Dissimilarity Matrix
fprintf('Calculate Dissimilarity Matrix ... \n');

D = zeros(n,n,p);
for i=1:p
    %D(:,:,i) = dissimilarityMatrix( X(:,i) );
    D(:,:,i) = pdist2(X(:,:,i),X(:,:,i));
end

% normalize matrix 
% D = dissimilarityNormalize( D );

%% Fuzzy c-medoids vectors clustering algorithm
fprintf('Fuzzy c-medoids ... \n');

K = 3;          % cantidad de grupos 
m = 1.2;        % paramaetro m    
T = 10;        % numero de iteraciones
e = 1e-500;     % umbral
[ G, Lambda, U, J, Jt, Gt ] = MVFCMddV(D, K, m, T, e );

% hard partition 
Q  = hardClusters(U);
W  = expandcol(Y,K); 
ARI = ajustedRandIndex(Q,W); %1043

fprintf('ARI = %d \n', ARI);

%% Show result


figure(2);
for i=1:p

    Xp = X(:,:,i);
    subplot(1,p,i); 
    plotDataPoints(Xp,vec2ind(Q')',K); 
    xlabel('X'); ylabel('Y'); 
    title(['XY: \theta = ' str{i}])
    box on;
    
    % Set the remaining axes properties
    set(gca, 'XGrid','on','YGrid','on');
    
    previous_centroids  = Xp(Gt(:,i,1),:);
    hold on;
    for j=1:size(Gt,3)
    centroids = Xp(Gt(:,i,j),:);
    plot(centroids(:,1), centroids(:,2), 'x', ...
    'MarkerEdgeColor','k', ...
    'MarkerSize', 10, 'LineWidth', 3);
    for k=1:size(centroids,1)
    drawLine(centroids(k, :), previous_centroids(k, :));
    end
    previous_centroids = centroids;
    drawnow;
    end
        
    centroids = Xp(G(:,i),:);
    plot(centroids(:,1), centroids(:,2), 'x', ...
     'MarkerEdgeColor','y', ...
     'MarkerSize', 10, 'LineWidth', 3);
    
    hold off;
    
end

%% Cost funcion draw

% % %  figure(3); plot(Jt);
% % %  title('Cost Function J(x)');
% % %  xlabel('Iteration');
% % %  ylabel('Error');
% % %  box on;
% % %  
% % %  % Set the remaining axes properties
% % %  set(gca, 'XGrid','on','YGrid','on');


