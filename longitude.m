function[y] = longitude(vecteur,CPR,latitude)
%% constante

long_ref = 0;
Nb = 17;


%% longitude 

Nl = cprNL(latitude);

if (Nl - CPR) >0
    Dlong = 360/(Nl-CPR);
else 
    Dlong = 360;
end 
LON = bi2de(vecteur(1:17),'left-msb');
m = floor(long_ref/Dlong) + floor(1/2 + (long_ref - Dlong*floor(long_ref/Dlong)/Dlong) - (LON/2^Nb));

y = Dlong*(m+LON/2^Nb);

end