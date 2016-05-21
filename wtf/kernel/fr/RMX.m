function p = RMX( varargin )
%Ecuation. Josef Kittler [14][15]
%Max Ruler


post = varargin{1}; %proba a posteriori
L = size(post,2);

if nargin == 2 %Ecu (1)
prior = varargin{2}; %probabilidad a priori
p = (1-L).*prior + L*max(Ppost,[],2); %[14]
else %Ecu (2)
p = max(post,[],2); %[15]
end

end
        
