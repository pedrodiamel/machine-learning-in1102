function [ AC, P, R, S, F1 ] = measuresEvaluate( Y, Yest )
%MEASURESEVALUATE: calculate measure of evaluate
% @breaf Calculo de las medidas de evaluacion
% @Ref: http://www.cnts.ua.ac.be/~vincent/pdf/microaverage.pdf

% Microaveraged results are therefore
% really a measure of effectiveness on the large classes in a test
% collection. To get a sense of effectiveness on small classes, you
% should compute macroaveraged results (Manning et al., 2008).
%
% OUTPUT
% stats is a structure array
% stats.confusionMat
%               Predicted Classes
%                    p'    n'
%              ___|_____|_____| 
%       Actual  p |     |     |
%      Classes  n |     |     |
%
% accuracy = (TP + TN)/(TP + FP + FN + TN) ; the average accuracy is returned
% precision = TP / (TP + FP)                  % for each class label
% sensitivity = TP / (TP + FN)                % for each class label
% specificity = TN / (FP + TN)                % for each class label
% recall = sensitivity                        % for each class label
% Fscore = 2*TP /(2*TP + FP + FN)             % for each class label
%
% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative
% 


C = length(unique(Y));
Y = expandcol(Y, C);
Yest = expandcol(Yest, C);


[c,cm,ind,per] = confusion(Y',Yest');

FN = per(:,1);
FP = per(:,2);
TP = per(:,3);
TN = per(:,4);


AC = 1-c;
P = (1/C)*sum(TP./(TP+FP)); % precision
R = (1/C)*sum(TP./(TP+FN)); % sensitivity or recall
S = (1/C)*sum(TN./(FP+TN)); % specificity
F1 = (1/C)*sum(2*TP./(2*TP + FP + FN + eps));

end

