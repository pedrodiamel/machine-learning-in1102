function [H,p] = nemenyiposthoc(a)
% --- Nemenyi post-hoc test
% Needs Statistics Toolbox & function RANKS
% a_ji is the error of model j on data set i
% N rows, M columns

[N,M] = size(a);
r = ranks(a')'; R = mean(r);
const = M * (M-1) / 2;
p = zeros(M,M);

for i = 1:M-1
    for j = i+1:M
        z = (R(i)-R(j))/sqrt(M*(M+1)/(6*N));        
        p(i,j) = 2*normcdf(-abs(z)); % two-tailed test
        p(j,i) = p(i,j);
    end
    p(i,i) = 1;
end
p(M,M) = 1;
p = min(1,p*const);

% calculate the hypothesis outcome at significance level 0.05
% H = 0 if the null hypothesis holds; H = 1 otherwise.
H = p < 0.05;

end
