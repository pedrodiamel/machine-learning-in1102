function Y = predictSvmMultSignal( model, X, W )
% PREDICTSVMMULTSIGNAL:
% @brief Y=predictSvmMultSignal(X,W,model) predict class for svm model
% @param model mlp 
% @param X signal in p subspace
% @param W clases 
%

p = length(X); % signal count
N = length(W); % cout objects
C = unique(W); % class
M = length(C); % cout class

% for each signal predict 
Y =  zeros(N,p);
for i=1:p
    
    % select signal
    Xp = X{i};
    
    Scores = zeros(N,M);
    for j=1:M
    
        % local implement
        % score = svmPredict(model{i}.model{j},Xp);
        
        % machine learning matlab toolbox
        [~,score] = predict(model{i}.model{j},Xp);
        Scores(:,j) = score(:,2);
    
    end
    
    [~,maxScore] = max(Scores,[],2);
    Y(:,i) = maxScore;    
    
end
end