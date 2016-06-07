function p = normdist( x, mu, Sigma )
%NORMDIST:
% funsion de densidad gausiana
% p( x_k|w_j, \theta_j)
%

d = length(mu);
p = (1/(((2*pi)^(d/2))*det(Sigma)^0.5)) * ...
    exp( (-1/2) * (x-mu)' / Sigma * (x-mu) );


end

