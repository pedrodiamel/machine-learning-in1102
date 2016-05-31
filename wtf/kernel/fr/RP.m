function p = RP( varargin )
% RP:
% @brief p=RP(P,PI): product ruler
% @param P list probabiliti
% @param PI (optional) prior probabiliti
% 
% Ecuation: Product Rule
% @f$ P^{(-(R-1))}( w_j )\prod_iP(w_j|x_i)  = \max_k P^{(-(R-1))}( w_k ) 
%     \prod_i P(w_k|x_i) (1) @f$
% which under the assumption of equal priors, simplifies to the following:
% @f$ \prod_iP(w_j|x_i)  = \max_k \prod_i P(w_k|x_i) @f$ (2)
%
% @ref: J. Kittler, M. Hatef, R. P. Duin, and J. Matas, "On combining 
% classifiers," Pattern Analysis and Machine Intelligence, IEEE 
% Transactions on, vol. 20, no. 3, pp. 226–239, 1998.
%
% @autor: Pedro Diamel Marrero Fernandez
% @date:  27/05/2016


post = varargin{1}; %proba a posteriori
L = size(post,2);

if nargin == 2 %Ecu (1)
prior = varargin{2}; %probabilidad a priori
p = (prior.^(-(L-1))).*prod(post,2);
else %Ecu (2)
p =  prod(post,2);  
end




end

