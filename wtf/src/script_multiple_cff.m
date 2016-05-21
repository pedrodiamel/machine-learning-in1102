%% Projeto AM 2016-1
% =========================================================================
% Exercise (2)
% Considere novamente os dados "multiple features".
% a) Use o classificador Bayesiano e classifique os exemplos segundo a regra
%    do voto majorit�rio.
% b) Classifique os exemplos segundo a regra do voto majorit�rio com o MLP e
%    depois com o SVM:
% c) Com os resultados do voto maj�rit�rio aplicado ao classificador 
%    Bayesiano, MLP e SVM, use novamente o voto majorit�rio para realizar a 
%    classifica��o final Classificar Z na classe wj se
% -------------------------------------------------------------------------
% Observa��es:
% ------------------------------------------------------------------------- 
% a) Use valida��o cruzada estratificada para avaliar e comparar esses
%    classificadores
% b) Obtenha uma estimativa pontual e um intervalo de confian�a para a taxa
%    de acerto de cada classificador
% c) usar Friedman test (teste n�o parametrico) para comparar os
%    classificadores. Usar tamb�m o Nemenyi test (pos teste)
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
DB = load([path_in_db 'mfeatfac.mat'],'X'); X{1} = DB.X(1:n,:);
DB = load([path_in_db 'mfeatfou.mat'],'X'); X{2} = DB.X(1:n,:);
DB = load([path_in_db 'mfeatkar.mat'],'X'); X{3} = DB.X(1:n,:);

% class create
W  = repmat(1:C,200,1); W = W(:); % class 

% normalize vector
X{1} = featureNormalize(X{1}); % signal fac normalize
X{2} = featureNormalize(X{2}); % signal fou normalize
X{3} = featureNormalize(X{3}); % signal kar normalize

%--------------------------------------------------------------------------
%% Croos validation configuare

k = 40; 
pt = cvpartition(W,'k', k);   


%--------------------------------------------------------------------------
%% Multiclasification 
% a) Use o classificador Bayesiano e classifique os exemplos segundo a regra
%    do voto majorit�rio.
%
%   S1   +-+    
%   ---> | | --+ ...         ----+
%        +-+                     |
%              +--+ NB  ---+     |
%   Sp   +-+   |           |     |
%   ---> | | --+--+ SVM --(+)---(+)-------- > 
%        +-+   |           |     |
%              +--+ MLP ---+     |
%   Sp   +-+                     |
%   ---> | | --+ ...        -----+
%        +-+  
%               
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
    
        % NB model
        % modMultBayes = fitBayesModelMultSignal(Xtr, Wtr);
        
        % SVM model
        modMultSvm = fitSvmModelMultSignal(Xtr,Wtr);
        
        % MLP model
        % modMultMlp = fitMlpModelMultSignal(Xtr, Wtr);
       
        % RL model
        
    
            
    %-------------------------------------------
    % TEST
    
    % predict class 
    
        % NB predict
        % Yest = predictBayesMultSignal( Xte, Wte, modMultBayes );
    
        % SVM predict
        Yest = predictSvmMultSignal( Xte, Wte, modMultSvm );
    
                
    % clasification fusion (max ruler)
    West = fusionRuler(Yest);    
        
    % calculo de error
    err(kf) = classError(Wte,West);
    
    % print
    fprintf('Iter %d, error: %d \n', kf, err(kf));
    
end

fprintf('\nResult: \n');
fprintf('E:%d St: %d \n', mean(err), std(err));
