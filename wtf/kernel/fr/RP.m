function p = RP( varargin )
%Ecuation. Josef Kittler [7]
%Product Rule
%P^{(-(R-1))}( w_j )\prod_iP(w_j|x_i)  = \max_k P^{(-(R-1))}( w_k ) \prod_i
%P(w_k|x_i) (1)
%which under the assumption of equal priors, simplifies to the following:
%\prod_iP(w_j|x_i)  = \max_k \prod_i P(w_k|x_i) (2)

post = varargin{1}; %proba a posteriori
L = size(post,2);

if nargin == 2 %Ecu (1)
prior = varargin{2}; %probabilidad a priori
p = (prior.^(-(L-1))).*prod(post,2);
else %Ecu (2)
p =  prod(post,2);  
end




end

