function P = predictMlpMultSignal( model, X, W )
% PREDICTMLPMULTSIGNAL:
% @brief Y=predictMlpMultSignal(X,W,model) predict class for mlp model
% @param model mlp 
% @param X signal in p subspace
% @param W clases 
%

p = length(X); % signal count
N = length(W); % cout objects
M = length(unique(W));

% for each signal predict 
P = zeros(N,M,p);

for i=1:p
    
    % Toolbox:
    % Neural Network toolbox (requiered)
    Xp = X{i}; net = model{i};
    post = net(Xp');
    P(:,:,i) = post';    
    
end
end

