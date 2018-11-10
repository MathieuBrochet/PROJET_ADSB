function[y] = altitude(vecteur_alt)

altitude_1 = vecteur_alt(1:7);
%on ne prend pas le 8eme bit, il y a 11 bits dans altitude
altitude_2 = vecteur_alt(9:12);

altitude_f = [altitude_1 altitude_2];

ra = bi2de(altitude_f,'left-msb'); % on convertit la valeur binaire, en valeur entiere

y  = 25*ra -1000;

end