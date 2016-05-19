function PI = prior( W )
% PI = prior( W ) estimate prior probability 
% @param W class
% @return PI prior probability

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases
N = length(W); % total de elemento 

% calculando la probilidad a priori
PI = zeros(C,1);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = W==i;
    
    % p(w_i) = |w_i|/|w|
    PI(i) = sum(w) / N;
    
end
end