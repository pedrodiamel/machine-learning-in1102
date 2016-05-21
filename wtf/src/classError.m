function err = classError( Y, Yest )
%err=classError(Y,Yest) calculate class error
%   Detailed explanation goes here

[n,m] = size(Yest);

% calculate error
err = sum(repmat(Y,1,m) ~= Yest, 1) ./ n;


end

