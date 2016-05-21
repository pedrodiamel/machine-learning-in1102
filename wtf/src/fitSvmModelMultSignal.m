function model = fitSvmModelMultSignal( X, W )
%model=fitBayesModel(X,W) fit svm model
%   Detailed explanation goes here

% signal count
p = length(X);
C = unique(W); % clases
M = length(C); % cout class

% create one model for each signal
model = cell(p,1);

% for each signal
for i=1:p
    
    % select signal
    Xp = X{i};
    
    % one against all
    svmmodel = cell(M,1);
    for j=1:M
        
        Wb = W==C(j);
        
        % local implement 
        % svmmodel{j} = svmTrain(Xp, Wb, 0.1, @linearKernel );

        % matlab implement toolbox 
        svmmodel{j} = fitcsvm(Xp, Wb );

    end
    
    
    % create model
    model{i}.model = svmmodel;    
    
end

end