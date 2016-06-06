function P = predictBayesMultSignal( model, X, W )
% PREDICTBAYESMULSIGNAL:
% @brief Y=predictBayesMultSignal(X,W,model) predict class for bayes model
% @param model bayes model X~N(\mu,\Sigma) 
% @param X signal in p subspace
% @param W clases 
%

p = length(X); % signal count
N = length(W); % cout objects
M = length(unique(W)); 

% for each signal predict 
P =  zeros(N,M,p); % probabiliti

for i=1:p
    
    % select signal
    Xp = X{i};
    
    % predict with bayes model
    for j=1:N    
       
        post = predictMult(model{i}, Xp(j,:)); 
        P(j,:,i) = post;
        
    end    
end


end