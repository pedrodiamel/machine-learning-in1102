function p = RMI( varargin )
%Ecuation. Josef Kittler [16][17]
%Min Ruler

post = varargin{1}; %proba a posteriori
L = size(post,2);

if nargin == 2 %Ecu (1)
prior = varargin{2}; %probabilidad a priori
p = (prior.^(-(L-1))).*min(post,[],2); %[16]
else %Ecu (2)
p = min(post,[],2); %[17]
end


end
        


