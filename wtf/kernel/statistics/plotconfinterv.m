function intv = plotconfinterv( n, mu, sigma, alpha, varargin )
% PLOTCONFINTERV:
% @brief intv=PLOTCONFINTERV(n,mu,sigma,alpha) plot of confidencial interval 
% @param n tamaño de la muestra
% @param mu medias muestral
% @param sigma desvios padron (cuando se desconese sqrt(mu.*(1-mu))) 
% @param alpha nivel de significancia
% @return intv intervalo de confianza [intv_+; intv_-]
%

% calculate
% \theta_{+/-} = \mu +/- t_{\alpha/2, n-1} * \sigma/\sqrt(n)
intv_c = mu + tpdf(alpha/2,n-1).*sigma./sqrt(n);
intv_l = mu - tpdf(alpha/2,n-1).*sigma./sqrt(n);
intv = [intv_c; intv_l];

m = numel(mu);
color = jet(m);

plot(mu,'-b', varargin{:});
hold on;
for i=1:m    
    plot(i,mu(i),'.b');
    line([i i],[intv_c(i) intv_l(i)],'LineStyle','-', 'Color', color(i,:));
    line([i-0.2 i+0.2],[intv_c(i) intv_c(i)],'LineStyle','-')
    line([i-0.2 i+0.2],[intv_l(i) intv_l(i)],'LineStyle','-')
end
hold off;

end