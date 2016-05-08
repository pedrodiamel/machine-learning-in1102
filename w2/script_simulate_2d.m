%% EM-algorithm demo
% Iterative EM procedure for normal mixture models.
% \autor: Pedro Diamel Marrero Fernandez
%%


MU1 = [2 2];
SIGMA1 = [2 0; 0 1];
MU2 = [-2 -1];
SIGMA2 = [1 0; 0 1];
rng(1); % For reproducibility
X = [mvnrnd(MU1,SIGMA1,100);mvnrnd(MU2,SIGMA2,100)];
Y=[ones(1,100) ones(1,100)*2 ]';


g = 4; maxiter = 10;
[Mu,Sigma,PI] = EM(X,g,  maxiter);


figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on

for j = 1:g
    xlim = Mu(j,1) + 4*[1 -1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[1 -1]*sqrt(Sigma(2,2,j));
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),[xlim ylim])
        % Draw contours for the multivariate normal distributions
end
h.XLim = cxlim;
h.YLim = cylim;
title('Expectation Maximization (EM), Artificial Data')
xlabel('X data')
ylabel('Y data')
hold off




