function Y = predictMlpMultSignal( model, X, W )
% PREDICTMLPMULTSIGNAL:
% @brief Y=predictMlpMultSignal(X,W,model) predict class for mlp model
% @param model mlp 
% @param X signal in p subspace
% @param W clases 
%

p = length(X); % signal count
N = length(W); % cout objects

% for each signal predict 
Y =  zeros(N,p);
for i=1:p
    
    Xp = X{i}; net = model{i};
    y = net(Xp');
    classes = vec2ind(y);
    Y(:,i) = classes(:); 
    
end
end

