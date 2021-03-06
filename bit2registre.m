function [registre] = bit2registre(vecteur, registre,Error)
%% CRC

%%   Mise � jour du registre
    if Error == 0 
        disp('message integre');
         registre.format = bi2de(vecteur(1:5),'left-msb');      
        if registre.format  == 17
            disp('Trame ADSB');
            registre.adresse = decodage(vecteur(9:32)); 
            registre.type = bi2de(vecteur(33:37),'left-msb');
            if registre.type >=1 & registre.type <=4 %message id
                registre.nom = decodage(vecteur(41:88));
            elseif registre.type >=9 & registre.type <=22 %message postion vol
                registre.altitude = altitude(vecteur(41:52)); %utilisation de fonction altitude
                registre.timeFlag = vecteur(53);
                registre.cprFlag =  vecteur(54);
                registre.latitude = abs(latitude(vecteur(55:71),vecteur(54))); %abs sinon bizare
                registre.longitude = longitude(vecteur(72:88),vecteur(54),registre.latitude);
                registre.trajectoire = [registre.trajectoire ;registre.latitude registre.longitude];
            end
            disp('registre mis � jour');
        else
            disp('Ce n est pas une trame ADSB');
        end
    else
        disp('CRC faux, message pas integre');
    end
    
    
    
   
end