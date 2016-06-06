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

n = 2000;   % number of objects file 
p = 3;      % number of signals X = {X_1, X_2, ... , X_p}
C = 10;     % number of class

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
DB = load([path_in_db 'mfeatzer.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
% DB = load([path_in_db 'mfeatmor.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;

% class create
W  = repmat(1:C,200,1); W = W(:); % class 

%--------------------------------------------------------------------------
%% Cross validation configuare

rng(1);
k = 40; 
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
    % get cv partition [Xtra, Xtest]
    [ Xtr, Wtr, Xte, Wte ] = getpartition( X, W, pt, kf );    
       
    %-------------------------------------------
    % TRAINING   

        % fit bayes model for each signal
        modMultBayes = fitBayesModelMultSignal(Xtr, Wtr);

        % calculo de la prob. priori
        PI = prior(Wtr);    
       
        
    %-------------------------------------------
    % TEST    

        % predict class 
        P = predictBayesMultSignal( modMultBayes, Xte, Wte );

        % clasification fusion
        [~, West] = fusionRuler(P, PI, 'may');    

        % calculo de error
        err(kf) = classError(Wte,West);
           
    % print
    fprintf('Iter %d, error: %d \n', kf, err(kf));
    
end

%% Result

acc = 1-err;

fprintf('\nResult: \n');
fprintf('ACC:%d St: %d \n', mean(acc), std(acc));


fg = figure;
ax = axes('Parent',fg,'YGrid','on',...
    'XTick',1, ...
    'XTickLabel',{  
    'NB'   
    },...
    'XGrid','on');

box(ax,'on');
hold(ax,'all');


% calculate
alpha = 0.05;
[ F, iC ] = intervalestimate( acc, alpha );
plotconfinterv( F, iC(:,1), iC(:,2) );


xlabel('method'); ylabel('acuracy')
title('Classificador Bayesiano for multiples features');



