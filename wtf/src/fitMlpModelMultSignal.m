function model = fitMlpModelMultSignal( X, W )
%model=fitBayesModel(X,W) fit bayes model
%   Detailed explanation goes here

% signal count
p = length(X);

% create one model for each signal
model = cell(p,1);

% for each signal
for i=1:p
    
    % select signal
    Xp = X{i};
    
    % calculo de la prob. priori
    PI = prior(W);
    
    % calculo de los estimadores
    % X~N(mu, st)
    [mu, Sigma] = estimateNaiveBayesGaussian(Xp, W);
    
    % create model
    model{i}.prior = PI;
    model{i}.mu = mu;
    model{i}.Sigma = Sigma;
    
end

end