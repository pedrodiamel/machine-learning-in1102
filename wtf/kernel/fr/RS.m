function p = RS( varargin )
%Ecuation. Josef Kittler [11]
%Sum Ruler
% $$(1-R)P( w_j ) + \sum_iP(w_j|x_i)  = \max_k [ (1-R)P(w_k) + \sum_iP(w_k|x_i)]$$
% which under the assumption of equal priors simplifies to the following:
% $$\sum_iP(w_j|x_i)  = \max_k \sum_iP(w_k|x_i)$$

post = varargin{1}; %proba a posteriori
L = size(post,2);

if nargin == 2 %Ecu (1)
prior = varargin{2}; %probabilidad a priori
p = (1-L).*prior + sum(post,2);
else %Ecu (2)
p = sum(post,2);
end

        


end

