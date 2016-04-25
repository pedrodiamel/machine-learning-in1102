function p = prior( W )

C = unique(W); % elimina los elementos repetidos
C = length(C); % total de clases
N = length(W); % total de elemento 

% calculando la probilidad a priori
p = zeros(C,1);
for i=1:C
 
    % seleccionando los elementos de la clase w_i
    w = W==i;
    
    % p(w_i) = |w_i|/|w|
    p(i) = sum(w) / N;
    
end

end