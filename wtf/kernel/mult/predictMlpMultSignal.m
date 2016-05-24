function Y = predictMlpMultSignal( X, W, model )
%Y=predictMlpMultSignal(X,W,model) predict class for mlp model
%   Detailed explanation goes here

p = length(X); % signal count
N = length(W); % cout objects

% for each signal predict 
Y =  zeros(N,p);
for i=1:p
    
    % select signal
    Xp = X{i};
    net = model{i};
    y = net(Xp');
    classes = vec2ind(y);
    
    Y(:,i) = classes(:);
    
end


end

