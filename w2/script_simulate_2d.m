%% EM-algorithm demo
% Iterative EM procedure for normal mixture models.
% \autor: Pedro Diamel Marrero Fernandez

rng(1); % For reproducibility

% generate data with normal distribution
size_p = 100;
[X,Y] = generateRandNormData( size_p );

% evaluate em
g = 4; maxiter = 10;
[Mu,Sigma,PI] = EM(X,g,  maxiter);

% draw result
figure
gscatter(X(:,1),X(:,2),Y);
h = gca;
cxlim = h.XLim;
cylim = h.YLim;
hold on

for j = 1:g
    xlim = Mu(j,1) + 4*[1 -1]*sqrt(Sigma(1,1,j));
    ylim = Mu(j,2) + 4*[1 -1]*sqrt(Sigma(2,2,j));
    ezcontour(@(x1,x2)mvnpdf([x1,x2],Mu(j,:),Sigma(:,:,j)),[xlim ylim]);
end
h.XLim = cxlim;
h.YLim = cylim;
title('Expectation Maximization (EM), Artificial Data')
xlabel('X data')
ylabel('Y data')
hold off




