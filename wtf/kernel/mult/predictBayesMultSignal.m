function Y = predictBayesMultSignal( X, W, model )
%Y=predictBayesMultSignal(X,W,model) predict class for bayes model
%   Detailed explanation goes here


p = length(X); % signal count
N = length(W); % cout objects

% for each signal predict 
Y =  zeros(N,p);
for i=1:p
    
    % select signal
    Xp = X{i};
    
    % predict with bayes model
    for j=1:N
    
        %Y(j,i) = predictNaiveBayes(Xp(j,:), model{i});
        Y(j,i) = predictMult(model{i}, Xp(j,:));
    
    end
    
end


end

