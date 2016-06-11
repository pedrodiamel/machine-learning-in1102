function [H,p] = bonferroniposthoc(a, o)
% --- Bonferroni-Dunn post-hoc test
% Needs Statistics Toolbox & function RANKS
% a_ji is the error of model j on data set i

% N rows, M columns
% The classifier of interest is in column 1 of a.
% The output contains M-1 results from the
% comparisons of columns 2:M with column 1

[N,M] = size(a);

r = ranks(a')'; R = mean(r);
const = M - 1;

% 
% i = 1; k=1;
% p = zeros(M,M);
% for i = 1:M-1
%     for j = i+1:M
%         
%         z = (R(i)-R(j))/sqrt(M*(M+1)/(6*N));
%         %p(i,j) = 2*normcdf(-abs(z)); % two-tailed test
%         p(i,j) = normcdf(z); % one-tailed test        
%         p(j,i) = p(i,j);        
%     end
%     p(i,i) = 1;
% end
% p(M,M) = 1;

i = o; %k=1;
p = ones(M,1);
for j = 1:M
        
    if i==j, continue; end
    
    z = (R(j)-R(i))/sqrt(M*(M+1)/(6*N));
    %p(j) = 2*normcdf(-abs(z)); % two-tailed test
    p(j) = normcdf(z); % one-tailed test
    %k=k+1;
    
    
end
p = min(1,p*const);

% calculate the hypothesis outcome at significance level 0.05
% H = 0 if the null hypothesis holds; H = 1 otherwise.
H = p < 0.05;
end

