function [ F, iC ] = intervalestimate( X, alpha )
%INTERVALESTIMATE: Summary of this function goes here
%   Detailed explanation goes here


% intervalos de confianza
[n,m] = size(X); 
F = mean(X);   
stdd2 = sqrt(F.*(1-F)./n);
alpha = 1 - alpha/2;

ET = ((n<30).*(tinv(alpha,n-1)) + (n>=30).*(norminv(alpha, 0, 1))) .* stdd2;
iC = [1;1]*F + [-1;1]*ET;
iC = iC';

end

