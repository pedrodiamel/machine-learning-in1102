function [ int ] = plotconfinterv( n, mu, sigma, alpha )


sigma = sqrt(mu.*(1-mu));
int_c = mu + tpdf(alpha/2,n-1).*sigma./sqrt(n);
int_l = mu - tpdf(alpha/2,n-1).*sigma./sqrt(n);
int = [int_c; int_l];

m = numel(mu);
color = jet(m);

figure;

hold on
plot(mu,'-b');
for i=1:m
    
plot(i,mu(i),'.b');
line([i i],[int_c(i) int_l(i)],'LineStyle','-', 'Color', color(i,:));
line([i-0.2 i+0.2],[int_c(i) int_c(i)],'LineStyle','-')
line([i-0.2 i+0.2],[int_l(i) int_l(i)],'LineStyle','-')

end
hold off



end

