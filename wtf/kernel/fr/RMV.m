function p = RMV( varargin )
%Ecuation. Josef Kittler [20]
%Majority Vote Rule


post = varargin{1}; %proba a posteriori
[C,L] = size(post);

dki = zeros(C,L);
for j=1:L
    [~,k] = max(post(:,j));
    dki(k,j) = 1;
end
p = sum(dki,2);





end
        