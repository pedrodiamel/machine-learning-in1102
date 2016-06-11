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
DB = load([path_in_db 'mfeatzer.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;
% DB = load([path_in_db 'mfeatmor.mat'],'X'); X{i} = DB.X(1:n,:); i = i + 1;

% class create
W  = repmat(1:C,200,1); W = W(:); % class 


%--------------------------------------------------------------------------
%% Croos validation configuare

rng(1);
k = 40; % 40
pt = cvtpartition(W, k);   

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
%% Configurate models

% MLP configuarete
mlpConfig.hiddenSizes = 25;
mlpConfig.transferFcn = 'softmax';    %softmax output
mlpConfig.trainFcn = 'trainscg';      %Scaled Conjugate Gradient trainbfg
mlpConfig.regularization = 0.5:0.1:0.8;
mlpConfig.show = false;

% SVM configurate
svmConfig.boxConstraint = 0.5:0.1:1; % regularization
svmConfig.kernelFunc = 'linear';  %'linear' 'rbf'
svmConfig.kernelScale = 'auto'; %
svmConfig.show = false;

% Fusion combination
fusionSignals = 'may';
fusionClassication = 'may';


% Error of systems
[ENB,ESVM,EMLP,Err] = deal(zeros(k,1));


for kf = 1:k 
        
    %-------------------------------------------
    % DATA
    % get cv partition
    [ Xtr, Wtr, Xva, Wva, Xte, Wte ] = getvpartition( X, W, pt, kf );
   
    %-------------------------------------------
    % TRAINING
    % Fit model
    fprintf('TRAINIG ... \n');
       
        % NB model
        fprintf('-|NB trainig \n');
        modMultBayes = fitBayesModelMultSignal(Xtr, Wtr);
        
        % SVM model
        fprintf('-|SVM trainig  \n');   
        modMultSvm = fitSvmModelMultSignal(Xtr,Wtr, Xva, Wva, svmConfig);
    
        % MLP model
        fprintf('-|MLP trainig \n');
        modMlpMult = fitMlpModelMultSignal( Xtr, Wtr, Xva, Wva, mlpConfig );
        
        % calculo de la prob. priori
        PI = prior(Wtr);
        
        
                
    % End fit model            
    %-------------------------------------------
    
    % TEST    
    % Predict for individual model 
    fprintf('TEST ... \n');
    
        % ===
        % NB predict
        fprintf('-|NB predit \n');
        PNBest = predictBayesMultSignal( modMultBayes, Xte, Wte );
        % NB clasification fusion
        [YNBest,WNBest] = fusionRuler(PNBest, PI, fusionSignals);        
        % NB calculo de error
        ENB(kf) = classError(Wte,WNBest);
        
        % ===        
        % SVM predict
        fprintf('-|SVM predit \n');
        PSVMest = predictSvmMultSignal( modMultSvm, Xte, Wte );
        % SVM clasification fusion
        [YSVMest,WSVMest] = fusionRuler(PSVMest, PI, fusionSignals);    
        % SVM calculo de error
        ESVM(kf) = classError(Wte,WSVMest);     
        
        % ===        
        % MLP model
        fprintf('-|MLP predit \n');
        PMLPest = predictMlpMultSignal( modMlpMult, Xte, Wte );
        % MLP clasification fusion
        [YMLPest,WMLPest] = fusionRuler(PMLPest, PI, fusionSignals);
        % MLP calculo de error
        EMLP(kf) = classError(Wte,WMLPest);
        
    % End Predict
    % predict for all model

    % All model outs (.*.)
    Pest = cat(3,YNBest, YSVMest, YMLPest);
    %Pest = cat(3,YNBest, YMLPest);
    
    % All clasification fusion
    [~, West] = fusionRuler(Pest, PI, fusionClassication);
    
    % Err calculo de error
    Err(kf) = classError(Wte,West);
        
        
    % print
    fprintf('Iter %d, error: %d \n', kf, Err(kf));
    
end

fprintf('\nResult: \n');
fprintf('E:%d St: %d \n', mean(Err), std(Err));


% save data
Data = 1 - [ENB ESVM EMLP Err];
%Data = 1 - [ENB EMLP Err];
csvwrite([path_out 'data.dat'], Data);

save('ws2-3.mat');

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

fg = figure;
ax = axes('Parent',fg,'YGrid','on',...
    'XTick',[1,2,3,4], ...
    'XTickLabel',{  
    'NB', 'SVM', 'MLP', 'ALL'   
    },...
    'XGrid','on');

box(ax,'on');
hold(ax,'all');


% calculate
alpha = 0.05;
[ F, iC ] = intervalestimate( Data, alpha );
plotconfinterv( F, iC(:,1), iC(:,2) );


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

fprintf('Nemenyi pos-hoc: \n');
[Hn,pn] = nemenyiposthoc(Data);
fprintf('Matrix p: \n'); disp(pn); 
fprintf('Matrix H: \n'); disp(Hn);

fprintf('Bonferroni pos-hoc: \n');
[Hb,pb] = bonferroniposthoc(Data,4);
fprintf('Matrix p: \n'); disp(pb); 
fprintf('Matrix H: \n'); disp(Hb);

end


