function P = predictSvmMultSignal( model, X, W )
% PREDICTSVMMULTSIGNAL:
% @brief Y=predictSvmMultSignal(X,W,model) predict class for svm model
% @param model mlp 
% @param X signal in p subspace
% @param W clases 
%

p = length(X); % signal count
N = length(W); % cout objects
M = length(unique(W)); % cout class

% for each signal predict 
P = zeros(N,M,p);

for i=1:p
    
    % select signal
    Xp = X{i};
    
    Post = zeros(N,M);
    for j=1:M
       
        % Toolbox:
        % Machine Learning Toolbox (requiered)
        [~,post] = predict(model{i}.model{j},Xp);
        Post(:,j) = post(:,2);
    
    end
    
    Post = softmax(Post')';
    P(:,:,i) = Post;
    
end

end