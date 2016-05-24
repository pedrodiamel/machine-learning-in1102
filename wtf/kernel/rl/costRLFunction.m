function [J, grad] = costRLFunction(theta, X, y, lambda)
%COSTRLFUNCTION Compute cost and gradient for logistic regression with regularization
%   J = COSTRLFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

% Initialize some useful values
m = length(y); % number of training examples

h_o = sigmoid(X*theta);

% cost function
JReg = (lambda/(2*m))*sum(theta(2:end).^2);
J = (1/m) * sum( -y.*log(h_o) - (1-y).*log(1-h_o) ) + JReg;

% \grad J
GReg = (lambda/m)*theta; GReg(1) = 0;
grad = ((1/m) * X'*(h_o - y)) + GReg;

end
