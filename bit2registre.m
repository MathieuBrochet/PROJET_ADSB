function [registre] = bit2registre(vecteur, registre)
    crc = vecteur(89:112);
    
    p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 
    CRC = crc.detector(p_g); % creation du crc detector  % partie décodage 

    [outdata, Error] = detect(CRC, crc);
    Error;
    
    if Error == 0 
        disp('message integre');
        registre.adresse = vecteur(9:32);
        registre.format = vecteur(1:5);
        registre.type = vecteur(33:58);
        registre.nom = vecteur(9:32);   % nom = adresse ? 
        registre.altitude = vecteur(41:52);
        registre.timeFlag = vecteur(53);
        registre.cprFlag = vecteur(54);
        registre.latitude = vecteur(55:71);
        registre.longitude = vecteur(72:88);
        registre.trajectoire = [registre.trajectoire ; registre.latitude registre.longitude];
        disp('registre mis à jour');
    else
        disp('CRC faux, message pas integre');
    end
    
   
end