function y = MV( dp )
%MV majority vote
%Imput
%dp decision profile
%
%Output
%y estimaciion de la clase
%

%Regla de votacion
y = mode(dp,2);

% [N,~] = size(dp);
% y = zeros(N,1);
% for i=1:N
%     
% y(i) = mode(dp(i,:));
% 
% % g = zeros(c,1);
% % for j=1:c
% % d = (dp(i,:) == j);
% % g(j) =  log((1-p)/(p*(c-1)))*log(prior(j)) +  sum(d);  
% % %g(j) = sum(d); 
% % end
% % [~,w] = max(g);
% % y(i) = w;
% 
% end




end

