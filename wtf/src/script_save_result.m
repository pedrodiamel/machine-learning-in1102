
clc; clear;
load('ws');


Q  = hardClusters(U);
W  = repmat(1:K,200,1); W = W(:); % class prior
W  = expandcol(W,K); 
ARI = ajustedRandIndex(Q,W);

% (i)   the fuzzy partition (matrix U)
% (ii)  the matrix weight (matix Lamnda)
% (iii) the hard partition (matix Q)
% (iv)  the list of medoids for groups (matrix G)
% (v)   rand index ajusted (RIA)

% csvwrite

csvwrite([path_out 'matU.dat'], U);
csvwrite([path_out 'matLambda.dat'], Lambda);
csvwrite([path_out 'matQ.dat'], Q);
csvwrite([path_out 'matG.dat'], G);

fprintf('ARI: %.3d \n', ARI);
