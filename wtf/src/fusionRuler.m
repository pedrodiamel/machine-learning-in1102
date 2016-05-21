function Y = fusionRuler( Ys )
%Y=fusionRuler(Ys,ruler) fusion ruler
%   Detailed explanation goes here

N = size(Ys,1);

% clasification fusion (max ruler)
Y = zeros(N,1);
for j=1:N
Y(j) = mode(Ys(j,:));
end


end

