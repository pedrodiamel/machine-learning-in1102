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
%   ---> | | --+
%        +-+   |     max
%              |----- + --> 
%   Sp   +-+   |
%   ---> | | --+
%        +-+   
%

err = zeros(k,1);

for kf = 1:k 
   
    trIdx = pt.training(kf); % training set 
    teIdx = pt.test(kf);     % test set 
          
    %-------------------------------------------
    % TRAINING
    
    % create one model for each signal
    modMultBayes = cell(p,1); 
    
    % for each signal
    for i=1:p
        
        Xp = X{i};
        Xtrai = Xp(trIdx,:); Wtrai = W(trIdx);
            
        % calculo de la prob. priori
        PI = prior(Wtrai); 
        
        % calculo de los estimadores
        % X~N(mu, st)
        [mu, Sigma] = estimateAllGaussian(Xtrai, Wtrai);
        
        % create model
        modMultBayes{i}.prior = PI;
        modMultBayes{i}.mu = mu;
        modMultBayes{i}.Sigma = Sigma;
            
    end
            
    %-------------------------------------------
    % TEST
      
    Wtest = W(teIdx);
    Nt = length(Wtest);
    Yp =  zeros(Nt,p); % estimate class for signal
         
    % for each signal
    for i=1:p
    
        Xp = X{i};
        Xtest = Xp(teIdx,:); 
    
        % evaluate each model   
        for j=1:Nt
        Yp(j,i) = predictAll(Xtest(j,:), modMultBayes{i}); 
        end
    
    end
        
    % clasification fusion (max ruler)
    Wp = zeros(Nt,1);
    for j=1:Nt
        Wp(j) = mode(Yp(j,:));        
    end
        
    % calculo de error
    err(kf) = sum(Wtest~=Wp)/Nt;
    
    fprintf('Iter %d, error: %d \n', kf, err(kf));
    
end

fprintf('\nResult: \n');
fprintf('E:%d St: %d \n', mean(err), std(err));
