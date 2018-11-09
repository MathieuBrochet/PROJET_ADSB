%% Mathieu Brochet, Elsa Dronet
clear all; 
close all;
clc;

%% Initialisation  constante
Ts = 1*10^-6; % symbol period 
Tp = 8*Ts;
Fp = 1/Tp;
sigma = 1;
delta_f = 500 ; % d�lais fr�quence 
Nb = 88; % nb of symbols 
Fse = 20; %nb of samples
Te= Ts/Fse; % samples period
Fe=1/Te;
Nt = 1/100*Te * ones(1,100*Fse); 
g=ones(1,Fse);% génération de g en échantillonnant au rythme Te
Eg = sum(g.^2); 
Eb_N0_db=linspace(0,10,11); % erreur binaire sur No en db 
Eb_N0 = 10.^(Eb_N0_db/10); %erreur binaire No
sigma2 = (sigma^2 * Eg) ./ (2*Eb_N0); % variance du bruit blanc
Sb = randi([0,1],1,Nb); %g�n�ration de Nb bit
p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 
delay_t = 46; %delais en temps (on choisit)
Pream = [1 0 1 0 0 0 0 1 0 1 0 0 0 0 0 0]; %frequence de 0,5*Fse sur�chantillonag
Pream_f = []; % vecteur qui contient les bits au rythme fse
DELAY = zeros(1,delay_t);

%% encodage

CRC = crc.detector(p_g); % creation du crc detector  % partie d�codage 
gen = comm.CRCGenerator(p_g); %creation du crc g�n�rator % partie encodage
Sb=Sb.';  % transpose la matrice
Sb_encoded=step(gen,Sb); % Sb encod�

Nb = 112;
%% PPM 

p0 = zeros(1,Fse); 
p1 = zeros(1,Fse);

for i=(Fse/2)+1:Fse
    p0(i)=1;
end

for i=1:Fse/2
    p1(i)=1;
end
pk = zeros(Nb,Fse);


for k=1:Nb
    if Sb_encoded(k)==0
        pk(k,:)=p0;
    else
        pk(k,:)=p1;
    end
end 


 Sl = reshape(pk.',1,[]);

%% echantillonage au rythme Fse = 20 

for i=1:length(Pream)
    if Pream(i) ==1 
        Pream_f(i,:) = ones(10,1);
    end
    if Pream(i) == 0
        Pream_f(i,:) = zeros(10,1);
    end 
end

Sp = reshape(Pream_f.',1,[]); % preambule sur-echantillner au rythme Fse
Sl_final = [Sp Sl]; % ajout du pr�ambule � Sl apr�s la PPm

%% impl�mentation du bruit
for i=1:length(sigma2)
    nl = sqrt(sigma2(i)).*randn(1,length(Sl_final)+delay_t);
end 

%% ajout du d�lais � Sl
Sl_f = [DELAY Sl_final];

%% calcul de Yl
 time = 1:1:length(Sl_f); % temps 
 Yl = Sl_f.*exp(-j*2*pi*delta_f*time) ;
%% obtention du delay

delay = synch(Sp,Yl);


%% Rl 


for i=1:Fse/2 
    p(i) = 0.5;
    
end


for i=(Fse/2)+1:Fse 
    p(i) = -0.5;
    
end


Rl = conv(p,Sl);
%% Echantillonage

Rm = zeros(1,Nb);
for i=1:Nb
    Rm(i) = Rl(i*Fse);
end



%% D�cision 

B = zeros(1,Nb); %vector of final bits
for i=1:Nb
   if Rm(i) <0 
       B(i) = 1;
   else  
       B(i) = 0;
   end
end

%% affichage de message int�gre ou non
B=B.';



%% Partie d�codage
[outdata, Error] = detect(CRC, B); 
%% test pour affichage
if Error == 0 
    disp(' Message int�gre'); % �quivaut � noErrors = 1
else 
    disp('Le message n est pas int�gre'); % �quivaut � noErrors = 0
end
noErrors = isequal(Sb, outdata) ;
Error ;




