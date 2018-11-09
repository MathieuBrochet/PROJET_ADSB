function [message] = decodage(vecteur)

    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    entiers = '0123456789';
    size = 6;
    len_vecteur = length(vecteur);
    
    for i=1:(len_vecteur/size)-1
       valeur = bi2de(vecteur(i*size:i*(size+1)), 'left-msb')
       
       if valeur >0 && valeur <=26
           message(i) = alphabet(valeur);
       elseif valeur == 32
           message(i) = ' ';
       elseif valeur >=48 && valeur <=57
           message(i) = entiers(valeur-47);
       end
    end   
           
end