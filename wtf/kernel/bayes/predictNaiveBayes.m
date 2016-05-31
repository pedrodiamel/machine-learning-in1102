function [w,p] = predictNaiveBayes( model, x )
% PREDICTNATIVEBAYES:
% @brief [w,p]=predictMult(X,model) predic class for vector x
% @param x object
% @param model bayes model
% @return w class hard
% @return p  max posterirori probability  max_i P( w_i | x)

x = x(:);
PI = model.prior;
mu = model.mu; Sigma2 = model.Sigma;
k = length(x); % dimencion de la data

% probabilidad a posteriori
C = length(PI);
p = zeros(C,1);
for i=1:C
 
     mu_i = mu(i,:)'; Sigma2_i = Sigma2(i,:);

    if (size(Sigma2_i, 2) == 1) || (size(Sigma2_i, 1) == 1)
    Sigma2_i = diag(Sigma2_i);
    end

    xi = bsxfun(@minus, x, mu_i)';
    p(i) = (2 * pi) ^ (- k/2) * det(Sigma2_i) ^ (-0.5) * ...
        exp(-0.5 * sum(bsxfun(@times, xi * pinv(Sigma2_i), xi), 2));
     
end


% % % discriminante ruler
% % C = length(PI);
% % p = zeros(C,1);
% % for i=1:C
% %  
% %      mu_i = mu(i,:)'; sigma2_i = Sigma2(i,:)';
% % 
% %     % g_j(x) = log(p(w_j)) - \sum_l^d(\sigma_{j,l} - (1/2)\sum_l^d \frac{x_l-\mu_{j,l}}{\sigma^2_{j,l}})
% %     p(i) = log(PI(i)) - sum(log(sigma2_i)) - (1/2) * sum( ((x-mu_i).^2)./sigma2_i );
% %     
% % end

% max ruler
% p( w | x ) = max_i p( w_i | x)
[p, w] = max(p);




end

