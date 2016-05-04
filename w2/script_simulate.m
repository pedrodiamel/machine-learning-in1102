
clear; clc;

n = 100;
norm1 = normrnd(25,1,n,1);
norm2 = normrnd(15,1,n,1);
norm3 = normrnd(30,1,n,1);
norm = [norm1 ; norm2; norm3];

% % hold on
% % plot(norm1, ones(n,1),'or');
% % plot(norm2, ones(n,1),'ob');
% % hold off;

y = norm;
g = 3;
[Mu,Sigma,PI] = EM(y(:),g);

x = 1:200;
nf1 = normpdf(x,Mu(1),Sigma(1,1,1));

x = 1:200;
nf2 = normpdf(x,Mu(2),Sigma(1,1,2));

x = 1:200;
nf3 = normpdf(x,Mu(3),Sigma(1,1,3));


hold on;
plot(norm, zeros(3*n,1),'ok');
plot(x,nf1);
plot(x,nf2);
plot(x,nf3);

plot(Mu(1),0,'or');
plot(Mu(2),0,'ob');
plot(Mu(2),0,'og');
hold off;


