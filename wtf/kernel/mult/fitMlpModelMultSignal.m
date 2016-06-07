function modelMlp = fitMlpModelMultSignal( Xt, Wt, Xv, Wv, mlpConfig )
%FITMLPMODELMULTSIGNAL:
% @brief model=fitMlpModelMultSignal(X,W) fit MLP model
% @param X signals 
% @param W class
% 
%


% signal count
p = length(Xt);
W = expandcol(Wt, length(unique(Wt)) );

% configurate
% net = network;
showValidate = mlpConfig.show;
hiddenSizes = mlpConfig.hiddenSizes;
trainFcn = mlpConfig.trainFcn; 
transferFcn = mlpConfig.transferFcn;
regularization = mlpConfig.regularization;

sizeParam = length(regularization);


% create one model for each signal
modelMlp = cell(p,1);

% for each signal
for i=1:p
    
    % select signal
    Xtp = Xt{i}; Xvp = Xv{i};    
   
    % select and validate model
    nett = cell(sizeParam,1); 
    
    %eJ = zeros(sizeParam,1);
    [AC, P, R, S, F1] = deal(zeros(sizeParam,1));
    
    for k = 1:sizeParam
    
        % training
        net = patternnet(hiddenSizes, trainFcn);
        %net = feedforwardnet(hiddenSizes, trainFcn);        
        net.layers{2}.transferFcn = transferFcn;  
        net.trainParam.showWindow = false;    
        net.performParam.regularization = regularization(k);
                
        nett{k} = train(net,Xtp',W');    
        
        % validate
        % Toolbox:
        % Neural Network toolbox (requiered)
        modelNet = nett{k};
        post = modelNet(Xvp');
        [~,West] = max(post,[],1);
        West = West';
        
        %eJ(k) = classError(Wv,West);
        [ AC(k), P(k), R(k), S(k), F1(k) ] = measuresEvaluate( Wv,West);
        
    end
    
    % select the best model
    [ac,idx] = max(AC);
    
    % model
    modelMlp{i}.model = nett{idx};  
    modelMlp{i}.eval = [AC, P, R, S, F1];
    modelMlp{i}.ac = ac;  
        
    
end


if showValidate
  figure; hold on;  
  for i=1:p
        
      R = modelMlp{i}.eval(:,3);
      S = modelMlp{i}.eval(:,4);
      R = [0; sort(R); 1];    % sensitivity 
      S = [0; sort(1-S); 1];  % specificity     
      plot(S,R,'-o');      

  end 
  fprintf('press continue \n')
  pause;
end



end