function p = RMD( varargin )
%Ecuation. Josef Kittler [18]
%Median Ruler

post = varargin{1}; %proba a posteriori
L = size(post,2);
p = (1/L)*sum(post,2); 


end
        