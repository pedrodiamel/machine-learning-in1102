function plotconfinterv(mu, intv_c, intv_l, varargin )
% PLOTCONFINTERV:
% @brief intv=PLOTCONFINTERV(intv_c, intv_l) plot of confidencial interval 

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