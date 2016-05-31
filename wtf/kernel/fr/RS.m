function p = RS( varargin )
% RS:
% @brief: p = RS(P,PI) sum ruler
% @param P list probabiliti
% @param PI (optional) prior probabiliti
%
% Ecuation. Josef Kittler [11]
% Sum Ruler
% $$(1-R)P( w_j ) + \sum_iP(w_j|x_i)  = \max_k [ (1-R)P(w_k) + \sum_iP(w_k|x_i)]$$
% which under the assumption of equal priors simplifies to the following:
% $$\sum_iP(w_j|x_i)  = \max_k \sum_iP(w_k|x_i)$$
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
p = (1-L).*prior + sum(post,2);
else %Ecu (2)
p = sum(post,2);
end

        


end

