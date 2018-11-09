function[delay] = synch(Sp,Yl)



CORR_sp = sqrt(dot(Sp,Sp)); % scalaire integrale sp 

for i=1:100 % taille de variation du delta
    for j=i+1:length(Sp)
        CORR_num(j) = sum(Yl(:,j).*Sp(:,j-i)); % calcul numérateur
        CORR_den(j) = sum(abs(Yl(:,j)).^2); 
        CORR_den_f(j) = CORR_sp*sqrt(CORR_den(:,j));% calcul dénominateur 
    end
end
%% calcul intercorrélation 
CORR = CORR_num./CORR_den_f;

%% recherche de l'index du Max
[Max index] = max(abs(CORR).^2);


%% obtention du délais 
delay = index-1;

end 