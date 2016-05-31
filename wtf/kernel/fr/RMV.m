function p = RMV( varargin )
% RMV:
% @brief p=RMV(P) Majority Vote Rule 
%
% Ecuation. Josef Kittler [20]
% 
% @ref: J. Kittler, M. Hatef, R. P. Duin, and J. Matas, "On combining 
% classifiers," Pattern Analysis and Machine Intelligence, IEEE 
% Transactions on, vol. 20, no. 3, pp. 226–239, 1998.
%
% @autor: Pedro Diamel Marrero Fernandez
% @date:  27/05/2016


post = varargin{1}; % posteriori
[C,L] = size(post);

dki = zeros(C,L);
for j=1:L
    [~,k] = max(post(:,j));
    dki(k,j) = 1;
end

p = sum(dki,2)./L;

end       