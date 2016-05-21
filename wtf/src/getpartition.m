function [ Xtr,Wtr,Xte,Wte ] = getpartition( X, W, pt, k )
%[Xtr,Wtr,Xte,Wte]=getpartition(X,pt,k) 
%   Detailed explanation goes here

p = length(X);

trIdx = pt.training(k); % training set
teIdx = pt.test(k);     % test set

% select data
Wtr = W(trIdx); Wte = W(teIdx);
Xtr = cell(p,1); Xte = cell(p,1);
for i=1:p
    Xp = X{i};
    Xtr{i} = Xp(trIdx,:);
    Xte{i} = Xp(teIdx,:);
end

end