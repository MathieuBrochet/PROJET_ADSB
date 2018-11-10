function[y] = latitude(vecteur, CPR)
%% constante
Nz = 15;
lat_ref = 0;
Nb = 17;
%% latitude
Dlat = 360/(4*Nz-CPR);
LAT = bi2de (vecteur,'left-msb');
j = floor(lat_ref/Dlat) + floor(1/2 + ((lat_ref-Dlat*floor(lat_ref/Dlat))/Dlat) - LAT/2^Nb);
y = Dlat*(j+LAT/2^Nb);

end 