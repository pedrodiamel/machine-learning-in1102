function model = fitMlpModelMultSignal( X, W )
% FITMLPMODELMULTSIGNAL:
% @brief model=fitMlpModelMultSignal(X,W) fit MLP model
% @param X signals 
% @param W class
% 
%

% signal count
p = length(X);
W = expandcol(W, length(unique(W)) );

% create one model for each signal
model = cell(p,1);

% for each signal
for i=1:p
    
    % select signal
    Xp = X{i};
    
    net = patternnet(10);
    net.trainParam.showWindow = false;
    net = train(net,Xp',W');
    
    model{i} = net;  
    
end
end