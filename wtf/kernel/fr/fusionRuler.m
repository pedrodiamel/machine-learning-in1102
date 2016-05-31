function [p,w] = fusionRuler( P, prior, varargin )
% FUSIONRULER:
% @brief Y=fusionRuler(Ys,ruler) fusion ruler implementation
% @param P posteriori probabiliti P(w|x)_k 
% @param ruler ruler fusion 
% @return Y hard class
% @return P soft clasification
%
% ---+
%    |    fusion  
% ---+     ruler
%  . | ---( + ) --- >
%  . |
%  . |
% ---+
%
% @ref: J. Kittler, M. Hatef, R. P. Duin, and J. Matas, "On combining 
% classifiers," Pattern Analysis and Machine Intelligence, IEEE 
% Transactions on, vol. 20, no. 3, pp. 226–239, 1998.
%
% @autor: Pedro Diamel Marrero Fernandez
% @date:  27/05/2016


rulerfunc = {@RP, @RS, @RMV, @RMX, @RMI, @RMD};
rulerstr  = {'prod', 'sum', 'may', 'max', 'min', 'med'};

ruleridx = 1;
if nargin == 3
ruler = varargin{1};
ruleridx = strcmp(rulerstr, ruler);
ruleridx = find(ruleridx);
end

% select funsion fuler
func = rulerfunc{ruleridx};

[N,M,K] = size(P);
p = zeros(N,M);
post = zeros(M,K);

for i=1:N

    post(:,:) = P(i,:,:);    
    p(i,:) = feval(func, post, prior);   
    
end

% max P
[~,w] = max(p,[],2);


end
