function [H,p] = imandavenport(a)
% --- Iman and Davenport test for N classifiers on M data sets
% Needs Statistics Toolbox
% a_ji is the error of model j on data set i
% N rows, M columns
[N,M] = size(a);

r = ranks(a')'; R = mean(r);
x2F =12*N/(M*(M+1))*(sum(R.^2) - M*(M+1)^2/4);

% ===
% MATLAB Stats Toolbox variant with additional correction
% for tied ranks:
% [~ ,t] = friedman(a,1,'off');
% x2F = t{2,5} % Friedman chiˆ2 statistic
% ===

FF = (N-1) * x2F / (N*(M-1) - x2F); % amended
p = 1 - fcdf(FF,(M-1),(M-1)*(N-1)); % p-value from the F-distribution
% calculate the hypothesis outcome at significance level 0.05
% H = 0 if the null hypothesis holds; H = 1 otherwise.
H = p < 0.05;

end
