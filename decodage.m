
function [message] = decodage(vecteur) 
 
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 
    entiers = '0123456789'; 
    size = 6; 
    len_vecteur = length(vecteur); 
    j=1;
     
    for i=1:size:(len_vecteur) 
          
       valeur = bi2de(vecteur(i:i+size-1), 'left-msb') ;
        
       if valeur >0 && valeur <=26 
           message(j) = alphabet(valeur); 
       elseif valeur == 32 
           message(j) = ' '; 
       elseif valeur >=48 && valeur <=57 
           message(j) = entiers(valeur-47); 
       end 
       
       j=j+1;
       
    end    
     
            
end