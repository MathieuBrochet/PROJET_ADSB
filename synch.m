function[CORR_1] = synch(Sp,Yl)


CORR_sp = sqrt(dot(Sp,Sp)); % scalaire integrale sp 

for i=0:100 % taille de variation du delta
        time_axis = i+1:i+length(Sp);
        CORR_num(time_axis) = sum(Yl(time_axis).*Sp(time_axis-i)); % calcul numérateur
        CORR_den(time_axis) = sum(abs(Yl(time_axis)).^2); 
        CORR_den_f(time_axis) = CORR_sp*sqrt(CORR_den(time_axis));% calcul dénominateur 
end

%% calcul intercorrélation 
CORR = CORR_num./CORR_den_f;

%% recherche de l'index du Max
% [Max index] = max(abs(CORR).^2);
CORR_1 = abs(CORR).^2;




%% obtention du délais 

end 