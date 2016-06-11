function modelSvm = fitSvmModelMultSignal( Xt, Wt, Xv, Wv, svmConfig )
% FITSVMMODELMULTSIGNAL:
% @brief model=fitSvmModel(X,W) fit svm model
% @param X signal vector in each subspace \R^{n,p}
% @param W clases

% signal count
p = length(Xt);
% % C = unique(Wt); % clases
% % M = length(C); % cout class

% create one model for each signal
modelSvm = cell(p,1);

showValidate =  svmConfig.show;
boxConstraint = svmConfig.boxConstraint; % regularization
kernelFunc = svmConfig.kernelFunc; 
kernelScale = svmConfig.kernelScale;
sizeParam = length(boxConstraint);


% for each signal
for i=1:p
    
    % select signal
    Xp = Xt{i}; Xvp = Xv{i};
    
    % select and validate model
    svmm = cell(sizeParam,1); 
    
    %eJ = zeros(sizeParam,1);   
    [AC, P, R, S, F1] = deal(zeros(sizeParam,1));
    
    for k = 1:sizeParam
    
        % training
        t = templateSVM( 'KernelFunction',kernelFunc, ...
            'BoxConstraint', boxConstraint(k), ...
            'KernelScale', kernelScale, ...
            'Standardize', true  );
        
        svmm{k} = fitcecoc(Xp, Wt, 'Learners', t);
        
        % validation
        % Toolbox:
        % Neural Network toolbox (requiered)
        [West, ~] = predict(svmm{k}, Xvp);
        
        %eJ(k) = classError(Wv,West);    
        [ AC(k), P(k), R(k), S(k), F1(k) ] = measuresEvaluate( Wv,West);
        
 
    end
    
    
    
% % % %     % one against all
% % % %     svmmodel = cell(M,1);
% % % %     for j=1:M
% % % %         
% % % %         Wp = W==C(j);    
% % % %         
% % % %         % local implement 
% % % %         % svmmodel{j} = svmTrain(Xp, Wb, 0.1, @linearKernel );
% % % % 
% % % %         % matlab implement toolbox         
% % % %         svmmodel{j} = fitcsvm(Xp, Wp, ...
% % % %             'KernelFunction',kernelFunc, ...
% % % %             'BoxConstraint', boxConstraint, ...
% % % %             'KernelScale', kernelScale, ...
% % % %             'Standardize', true ); 
% % % %         
% % % %                
% % % % 
% % % %     end
        

    % select the best model
    [ac,idx] = max(AC);
    
    % model
    modelSvm{i}.model = svmm{idx};  
    modelSvm{i}.eval = [AC, P, R, S, F1];
    modelSvm{i}.ac = ac;  
    
end


if showValidate
    
  mark = {'square', 'o', '^'};
  name = {'FOU', 'KAR', 'ZER'};  
  fg = figure; 
  ax  = axes('Parent',fg);
  hold on;   
  
  for i=1:p
        
      R = modelSvm{i}.eval(:,3);
      S = modelSvm{i}.eval(:,4);
      R = [0; sort(R); 1];    % sensitivity 
      S = [0; sort(1-S); 1];  % specificity     
      plot(S,R,'DisplayName', name{i}, 'Marker', mark{i});      

  end 
  xlabel('sensitivity'); ylabel('specificity')  
  title('ROC curve');
  box(ax,'on');
  grid(ax,'on');
  % Create legend
  legend(ax,'show');
  hold off;
  
  fprintf('press continue \n')
  pause;
end



end