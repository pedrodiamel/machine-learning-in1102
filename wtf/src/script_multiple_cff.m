%% PROJETO AM 2016-1
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

k = 40; % 40
pt = cvpartition(W,'k', k);   


%--------------------------------------------------------------------------
%% Multiclasification 
% b) Obtenha uma estimativa pontual e um intervalo de confianï¿½a para a taxa
%    de acerto de cada classificador.
%
%   S1   +-+    
%   ---> | | --+ ...         ----+
%        +-+                     |
%              +--+ NB  ---+     |
%   Sk   +-+   |           |     |
%   ---> | | --+--+ SVM --(+)---(+)-------- > 
%        +-+   |           |     |
%              +--+ MLP ---+     |
%   Sp   +-+                     |
%   ---> | | --+ ...        -----+
%        +-+  
%               
%

ENB  = zeros(k,1);
ESVM = zeros(k,1);
EMLP = zeros(k,1);
Err  = zeros(k,1);


for kf = 1:k 
        
    %-------------------------------------------
    % DATA
    % get cv partition
    [ Xtr, Wtr, Xte, Wte ] = getpartition( X, W, pt, kf );
   
    %-------------------------------------------
    % TRAINING
    % Fit model
       
        % NB model
        modMultBayes = fitBayesModelMultSignal(Xtr, Wtr);
        
        % SVM model
        modMultSvm = fitSvmModelMultSignal(Xtr,Wtr);
    
        % MLP model
        modMlpMult = fitMlpModelMultSignal( X, W );
                
    % End fit model            
    %-------------------------------------------
    % TEST    
    % Predict for individual model 
        % ===
        % NB predict
        YNBest = predictBayesMultSignal( modMultBayes, Xte, Wte );
        % NB clasification fusion
        WNBest = fusionRuler(YNBest);
        % NB calculo de error
        ENB(kf) = classError(Wte,WNBest);
        
        % ===        
        % SVM predict
        YSVMest = predictSvmMultSignal( modMultSvm, Xte, Wte );
        % SVM clasification fusion
        WSVMest = fusionRuler(YSVMest);    
        % SVM calculo de error
        ESVM(kf) = classError(Wte,WSVMest);     
        
        % ===        
        % MLP model
        YMLPest = predictMlpMultSignal( modMlpMult, Xte, Wte );
        % NB clasification fusion
        WMLPest = fusionRuler(YMLPest);
        % NB calculo de error
        EMLP(kf) = classError(Wte,WMLPest);
        
    % End Predict
    % predict for all model

    % All model outs (.*.)
    Yest = [WNBest WSVMest WMLPest];
    
    % All clasification fusion
    West = fusionRuler(Yest);
    
    % Err calculo de error
    Err(kf) = classError(Wte,West);
        
        
    % print
    fprintf('Iter %d, error: %d \n', kf, Err(kf));
    
end

fprintf('\nResult: \n');
fprintf('E:%d St: %d \n', mean(Err), std(Err));


% save data
Data = 1 - [ENB ESVM EMLP Err];
csvwrite([path_out 'data.dat'], Data);

save('ws2.mat');

% -------------------------------------------------------------------------
%% Error ananlysis:
%
% a) Use validaï¿½ï¿½o cruzada estratificada para avaliar e comparar esses
%    classificadores
% b) Obtenha uma estimativa pontual e um intervalo de confianï¿½a para a taxa
%    de acerto de cada classificador
% c) usar Friedman test (teste nï¿½o parametrico) para comparar os
%    classificadores. Usar tambï¿½m o Nemenyi test (pos teste)
%

%% Data analysis

% intervalos de confianza
n = size(Data,1);
mu = mean(Data);
sigma = std(Data);
alpha = 0.05;


fg = figure;
% ax = axes('Parent',fg,'YGrid','on','XGrid','on');
ax = axes('Parent',fg,'YGrid','on',...
    'XTick',[1,2,3,4], ...
    'XTickLabel',{  
    'NB', 'SVM', 'MLP', 'ALL'   
    },...
    'XGrid','on');

box(ax,'on');
hold(ax,'all');

intv = plotconfinterv( n, mu, sigma, alpha );
xlabel('method'); ylabel('acuracy')
title('Combination model for multiples features');



%% Friedman test
fprintf('Friedman test \n');

% (1) H_0: mu_i - mu_j  = 0 Vi,j
% (2) H_1: mu_i - mu_j != 0 Ei,j
% (3) significance level 0.05  
% (4) Calculate:
p = friedman(Data,1,'off');
% (5) Validate:
H = p < 0.05;
% (6) Conclusion:
if H
fprintf('Rejeita H_0 com um nivel de %.3d \n', p);
else
fprintf('Não rejeita H_0\n');
end

% (7) Post-test
if H
fprintf('Nemenyi-post \n');
[H,p] = nemenyiposthoc(Data);

fprintf('Matrix p: \n'); disp(p); 
fprintf('Matrix H: \n'); disp(H);

end
