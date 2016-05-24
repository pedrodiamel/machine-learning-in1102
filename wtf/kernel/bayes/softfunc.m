function p = softfunc(h)
%SOFTFUNC - calculate soft function
%
% Syntax: p = softfunc(h)
%
% Long description
    
g = exp(h);  
p = bsxfun(@rdivide, g, sum(g,1));
    
end