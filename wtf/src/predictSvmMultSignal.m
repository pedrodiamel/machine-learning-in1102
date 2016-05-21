function Y = predictSvmMultSignal( X, W, model )
%Y=predictSvmMultSignal(X,W,model) predict class for svm model
%   Detailed explanation goes here

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
        
        % matlab implement toolbox
        [~,score] = predict(model{i}.model{j},Xp);
        Scores(:,j) = score(:,2);
    
    end
    
    [~,maxScore] = max(Scores,[],2);
    Y(:,i) = maxScore;    
    
end
end