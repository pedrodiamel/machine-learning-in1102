function ari = ajustedRandIndex( varargin )
%randIndex=mesureRandIndex(X,Y)
%   Detailed explanation goes here


%% Create contingency table

if nargin > 1

X = varargin{1}; Y = varargin{2};
 
[~,k] = size(X);
[~,c] = size(Y);

%
% X\Y | Y1  Y2  ... Ys  | Sum
% ----+-----------------+----
%  X1 | n11 n12 ... n1s | a1
%  X1 | n11 n12 ... n1s | a2
%
%  X1 | nr1 nr2 ... nrs | ar 
% ----+-----------------+----
% Sum | b1  b2  ... bs  | 

Tc = zeros(k,c);
for i=1:k
 for j=1:c   
    Tc(i,j) = sum( (X(:,i) & Y(:,j) ) );
 end
end

else
Tc = varargin{1};
end

a = sum(Tc,2);
b = sum(Tc,1);
n = sum(a);


%% Calculo de  adjusted index
% for fast algorith
% comb(n,2) = \frac{n!}{2!*(n-2)!}
%           = \frac{n*(n-1)}{2}    
% 
% ARI = \frac{Index - ExpectedIndex}{MaxIndex - ExpectedIndex}

% Index
index = (0.5)* sum(sum(Tc.*(Tc-1)));

% ExpectedIndex
expectedIndex = (sum(a.*(a-1)) * sum(b.*(b-1)))/ (2*n*(n-1));

% MaxIndex
maxIndex = (0.25) * ((sum(a.*(a-1)) + sum(b.*(b-1))) );

% ARI
ari = (index - expectedIndex) / (maxIndex - expectedIndex + eps);


end






