clear all;
close all;
clc;



%% Initialisation  constante
Ts = 1*10^-6; % symbol period 
Tp = 8*Ts;
Fp = 1/Tp;
Fse = 4; %nb of samples
Te= Ts/Fse; % samples period
Fe=1/Te;
p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 
Yl_i = load('buffers.mat');
Yl = reshape(Yl_i.buffers.',1,[]);
%% Preambule
Pream = [1 0 1 0 0 0 0 1 0 1 0 0 0 0 0 0]; %frequence de 0,5*Fse sur�chantillonag
Pream_f = []; % vecteur qui contient les bits au rythme fse
for i=1:length(Pream)
    if Pream(i) ==1 
        Pream_f(i,:) = ones(Fse/2,1);
    end
    if Pream(i) == 0
        Pream_f(i,:) = zeros(Fse/2,1);
    end 
end
Sp = reshape(Pream_f.',1,[]); % preambule sur-echantillner au rythme Fse
%% synchronisation


tab_delay = [];
i=1;
corr = synch(Sp,Yl);
% while i<1000 
%    i
%    delay = synch(Sp,Yl(i : length(Yl))); % recupere la 1ere valeur 
%    if delay == -1
%        i = i+1;
%    else
%        i = i+delay;
%        tab_delay = [tab_delay i];
%    end
% end

