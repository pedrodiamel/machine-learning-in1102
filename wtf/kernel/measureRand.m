function rand = measureRand( X, Y )
%rand=measureRand(X,Y) calculate rand mesure  
% @breif Given a set of n elements S = \{o_1, \ldots, o_n\} and two partitions 
% of S to compare, X = \{X_1, \ldots, X_r\}, a partition of S into r 
% subsets, and Y = \{Y_1, \ldots, Y_s\}, a partition of S into s subsets,
% define the following:
%
% @param X 
% @param Y 
% @return rand
%
%

n = length(X);

% a, the number of pairs of elements in S that are in the same set in X and 
% in the same set in Y

a = sum(X&Y);

% b, the number of pairs of elements in S that are in different sets in X 
% and in different sets in Y

b = sum((~X)&(~Y));

% c, the number of pairs of elements in S that are in the same set in X and 
% in different sets in Y

c = sum((~X)&(Y));

% d, the number of pairs of elements in S that are in different sets in X 
% and in the same set in Y

d = sum((X)&(~Y));


% the rand index

rand = (a + b) / (a + b + c + d);



end

