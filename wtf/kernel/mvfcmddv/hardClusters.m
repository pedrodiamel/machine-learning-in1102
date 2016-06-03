function Q = hardClusters( U  )
%Q=HARDCLUSTERS(U) create hard clusters  
% @param U fusi partition 
% @return H hard partition
% 
% @autor: Pedro Diamel Marrero Fernandez

[~, Q] = max( U ,[],2);
Q = expandcol(Q,size(U,2));

% % [n,c] = size(U);
% % 
% % % Q = {Q_1, Q_2, ... Q_c}
% % % Q_i = { e_k : u_{i,k} >= u_{m,k} ; m \in {1, ... , c}}
% % Q = zeros(n,c);
% % for i=1:c
% %     for k=1:n        
% %         if all( U(k,i) - U(k,:) >= 0),  Q(k,i) = 1; end        
% %     end
% % end

end