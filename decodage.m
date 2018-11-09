
function [message] = decodage(vecteur) 
 
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 
    entiers = '0123456789'; 
    size = 6; 
    len_vecteur = length(vecteur); 
     
    for i=1:size:(len_vecteur) 
         
        
       valeur = bi2de(vecteur(i:i+size-1), 'left-msb') 
        
       if valeur >0 && valeur <=26 
           message(i) = alphabet(valeur); 
       elseif valeur == 32 
           message(i) = ' '; 
       elseif valeur >=48 && valeur <=57 
           message(i) = entiers(valeur-47); 
       end 
    end    
     
            
end