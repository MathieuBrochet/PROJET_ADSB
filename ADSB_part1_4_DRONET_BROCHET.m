%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

%% Initialisation 
Ts = 1*10^-6; % symbol period 
sigma = 1;
Nb = 88; % nb of symbols 
Fse = 20; %nb of samples
Te= Ts/Fse; % samples period
Fe=1/Te;
g=ones(1,Fse);% gÃ©nÃ©ration de g en Ã©chantillonnant au rythme Te
Eg = sum(g.^2); 
Eb_N0_db=linspace(0,10,11); % erreur binaire sur No en db 
Eb_N0 = 10.^(Eb_N0_db/10); %erreur binaire No
sigma2 = (sigma^2 * Eg) ./ (2*Eb_N0); % variance du bruit blanc
Sb = randi([0,1],1,Nb); %génération de Nb bit
p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 

%% encodage du message 

CRC = crc.detector(p_g); % creation du crc detector  % partie décodage 
gen = comm.CRCGenerator(p_g); %creation du crc générator % partie encodage
Sb=Sb.';  % transpose la matrice
Sb_encoded=step(gen,Sb); % Sb encodé

%% implémentation du bruit
Nb = 112; % on change la valeur de Nb pour s'adapter à la nouvelle longeur de Sb après encodage
for i=1:length(sigma2)
    nl = sqrt(sigma2(i)).*randn(1,Fse*Nb);
end 
%% PPM 

Sl = zeros(1,Fse*Nb); %vector of Sl samples
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


 Sl = reshape(pk.',1,[]) + nl;

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



%% Décision 

B = zeros(1,Nb); %vector of final bits
for i=1:Nb
   if Rm(i) <0 
       B(i) = 1;
   else  
       B(i) = 0;
   end
end

%% affichage de message intègre ou non
B=B.';



%% Partie décodage
[outdata, Error] = detect(CRC, B); 
%% test pour affichage
if Error == 0 
    disp(' Message intègre'); % équivaut à noErrors = 1
else 
    disp('Le message n est pas intègre'); % équivaut à noErrors = 0
end
noErrors = isequal(Sb, outdata) ;
Error ;