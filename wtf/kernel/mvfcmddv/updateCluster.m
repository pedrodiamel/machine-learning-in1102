%% Ecuation (4)
function G = updateCluster( D, U, K, m )
% \sum_i^n (u_{ik})d_j(e_i,g_j)-> Min

% % % [n,nn,p] = size(D);
% % % G = zeros(K,p);
% % % for k=1:K
% % %     for j=1:p        
% % %         % l = \arg_{1<h<n}  \sum_i^n (u_{ik})^m d_j(e_i,e_h)
% % %         cost = zeros(n,1);
% % %         for h=1:n, 
% % %             cost(h) = sum( (U(:,k).^m).*D(:,h,j) );  
% % %         end
% % %         [~,l] = min(cost);
% % %         G(k,j) = l;    
% % %         
% % %     end
% % % end


[n,~,p] = size(D);
G = zeros(K,p);
for k=1:K
    for j=1:p        
        % l = \arg_{1<h<n}  \sum_i^n (u_{ik})^m d_j(e_i,e_h)
        cost =  sum( repmat(U(:,k).^m,1,n) .* D(:,:,j),1 );
        [~,l] = min(cost);   
        G(k,j) = l;    
        
    end
end


end