function [ Xtr,Wtr,Xval,Wval,Xte,Wte ] = getvpartition( X, W, pt, k )
% GETVPARTITION: 
% @brief [Xtr,Wtr,Xval,Wval,Xte,Wte]=getpartition(X,pt,k) 
%   Detailed explanation goes here

p = length(X);

trIdx = gettraining(pt,k);
vaIdx = getvalidation(pt,k);
teIdx = gettest(pt,k);

% select data
Wtr = W(trIdx); Wte = W(teIdx); Wval = W(vaIdx);
Xtr = cell(p,1); Xte = cell(p,1); Xval = cell(p,1);
for i=1:p
    Xp = X{i};
    Xtr{i} = Xp(trIdx,:);
    Xte{i} = Xp(teIdx,:);
    Xval{i} = Xp(vaIdx,:);
end
end