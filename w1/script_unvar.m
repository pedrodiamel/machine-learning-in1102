%% Teoria de desicion de bayes
%% Initialization 
clear ; close all; clc 

%% Load data

fprintf('Cargar dataset ...\n') 
 
 
% create dataset 
% simpleclass_dataset   - Simple pattern recognition dataset. 
% cancer_dataset        - Breast cancer dataset. 
% crab_dataset          - Crab gender dataset. 
% glass_dataset         - Glass chemical dataset. 
% iris_dataset          - Iris flower dataset. 
% thyroid_dataset       - Thyroid function dataset. 
% wine_dataset          - Italian wines dataset. 
% 

filename = 'wine_dataset'; 
[objs,class] = wine_dataset; 
[M,N] = size(class); 
W = sum(ones(N,M)*diag(1:M).*class',2); 
X = objs'; 


%% Croos validation initialization

k = 10; 
pt = cvpartition(W,'k', k);   
K = pt.NumTestSets; 
L = 10; 

err = zeros(k,1);

for kf = 1:k 
   
    trIdx = pt.training(kf); %trai 
    teIdx = pt.test(kf);  %test 
     
    Xtrai = X(trIdx,1); Wtrai = W(trIdx);
    Xtest = X(teIdx,1); Wtest = W(teIdx);
    
    %-------------------------------------------
    % TRAINING
    
    % methods
    % calculo de la prob. priori
    P = prior(Wtrai); 
    
    % calculo de los estimadores
    % X~N(mu, st)
    [mu, sigma] = estimateGaussian(Xtrai, Wtrai);
    
    modBayes.prior = P;
    modBayes.mu = mu;
    modBayes.sigma = sigma;
    
    %-------------------------------------------
    % TEST
    
    Nt = length(Wtest);
    Ytest =  zeros(Nt,1); % clase estimada
    for i=1:Nt
    Ytest(i) = predict(Xtest(i), modBayes);        
    end
    
    % calculo de error
    err(kf) = sum(Wtest~=Ytest)/Nt;
    
    fprintf('Iter %d, error: %d \n', kf, err(kf));
    
end

fprintf('\nResult: \n');
fprintf('E:%d St: %d \n', mean(err), std(err));





