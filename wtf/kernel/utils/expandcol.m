function Yexp = expandcol( Y, m )
%Yexp=expandcol(Y,m)  expand vector class
%   Detailed explanation goes here

Ymin = min(Y);
if Ymin == 0
Y = Y + 1; 
end

n = length(Y);
Yexp = zeros(n,m);
for i=1:n
Yexp(i,Y(i)) = 1;
end

end

