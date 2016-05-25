%% Projeto AM 2016-1
% =========================================================================
% Exercise (2)
% Considere novamente os dados "multiple features".
% a) Use o classificador Bayesiano e classifique os exemplos segundo a regra
%    do voto majoritï¿½rio.
% b) Classifique os exemplos segundo a regra do voto majoritï¿½rio com o MLP e
%    depois com o SVM:
% c) Com os resultados do voto majï¿½ritï¿½rio aplicado ao classificador 
%    Bayesiano, MLP e SVM, use novamente o voto majoritï¿½rio para realizar a 
%    classificaï¿½ï¿½o final Classificar Z na classe wj se
% -------------------------------------------------------------------------
% Observaï¿½ï¿½es:
% ------------------------------------------------------------------------- 
% a) Use validaï¿½ï¿½o cruzada estratificada para avaliar e comparar esses
%    classificadores
% b) Obtenha uma estimativa pontual e um intervalo de confianï¿½a para a taxa
%    de acerto de cada classificador
% c) usar Friedman test (teste nï¿½o parametrico) para comparar os
%    classificadores. Usar tambï¿½m o Nemenyi test (pos teste)
%

%--------------------------------------------------------------------------
%% Initialization

clear ; close all; clc
run('addPathToKernel');

% global dir
path_in_db = '../db/';
path_out = '../out/';

fprintf('Projeto AM 2016-1 ... \n');
fprintf('Running multiclasification system ... \n');

%--------------------------------------------------------------------------
%% Load data
fprintf('Reading data file ... \n');

n = 2000;   % count object file 
p = 3;      % count signal 
C = 10;     % count class

X = cell(p,1);

% signal load file
% 1. mfeat-fou: 76 Fourier coefficients of the character shapes; 
% 2. mfeat-fac: 216 profile correlations;  ***
% 3. mfeat-kar: 64 Karhunen-Loève coefficients; *** 
% 4. mfeat-pix: 240 pixel averages in 2 x 3 windows; (15x16)
% 5. mfeat-zer: 47 Zernike moments; 
% 6. mfeat-mor: 6 morphological features. ***

i = 1;
% DB = load([path_in_db 'mfeatfac.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
DB = load([path_in_db 'mfeatfou.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
DB = load([path_in_db 'mfeatkar.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
% DB = load([path_in_db 'mfeatpix.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
% DB = load([path_in_db 'mfeatzer.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
DB = load([path_in_db 'mfeatmor.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;


% class create
W  = repmat(1:C,200,1); W = W(:); % class 

% normalize vector
X{1} = featureNormalize(X{1}); % signal fac normalize
X{2} = featureNormalize(X{2}); % signal fou normalize
X{3} = featureNormalize(X{3}); % signal kar normalize

%--------------------------------------------------------------------------
%% Croos validation configuare

k = 10; 
pt = cvpartition(W,'k', k);   


%--------------------------------------------------------------------------
%% Multiclasification 
% a) Use o classificador Bayesiano e classifique os exemplos segundo a regra
%    do voto majoritï¿½rio.
%
%   S1   +-+    
%   ---> | | --+
%        +-+   |     max
%        ...   |----- + --> 
%   Sp   +-+   |
%   ---> | | --+
%        +-+   
%

err = zeros(k,1);

for kf = 1:k 
        
    %-------------------------------------------
    % DATA    
    % get cv partition
    [ Xtr, Wtr, Xte, Wte ] = getpartition( X, W, pt, kf );    
       
    %-------------------------------------------
    % TRAINING   
    % fit model
    modMultBayes = fitBayesModelMultSignal(Xtr, Wtr);
                
    %-------------------------------------------
    % TEST    
    % predict class 
    Yest = predictBayesMultSignal( modMultBayes, Xte, Wte );
                
    % clasification fusion (max ruler)
    West = fusionRuler(Yest);    
        
    % calculo de error
    err(kf) = classError(Wte,West);
           
    % print
    fprintf('Iter %d, error: %d \n', kf, err(kf));
    
end

%% Result

acc = 1-err;

fprintf('\nResult: \n');
fprintf('ACC:%d St: %d \n', mean(acc), std(acc));

% intervalos de confianza
n = size(acc,1);    % size
mu = mean(acc);     % mean
sigma = std(acc);   % standar desviation
alpha = 0.05;       % confianza

fg = figure;
% ax = axes('Parent',fg,'YGrid','on','XGrid','on');
ax = axes('Parent',fg,'YGrid','on',...
    'XTick',1, ...
    'XTickLabel',{  
    'NB'   
    },...
    'XGrid','on');

box(ax,'on');
hold(ax,'all');

intv = plotconfinterv( n, mu, sigma, alpha );
xlabel('method'); ylabel('acuracy')
title('Classificador Bayesiano for multiples features');


