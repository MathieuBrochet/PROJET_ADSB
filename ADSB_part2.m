%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 
CRC = crc.detector(p_g); % creation du crc detector  % partie décodage 

REF_LON = -0.606629;
REF_LAT = 44.806884;

figure(1);
x = linspace(-1.3581,0.7128,1024);
y = linspace(44.4542,45.1683,1024);
im = imread('fond.png');
image(x,y(end:-1:1),im);
hold on
plot(REF_LON,REF_LAT,'.r','MarkerSize',20);
text(REF_LON+0.05,REF_LAT,'Actual pos','color','b')
set(gca,'YDir','normal')

xlabel('Longitude en degres');
ylabel('Lattitude en degres');
%% Structure de registre

registre = struct ( 'adresse', [], ...           % de 9 à 32   
                    'format', [], ...            % de 1 à 5
                    'type', [], ...              % de 33 à 38 format FTC determine le mode des trames
                    'nom', [], ...               % adresse
                    'altitude', [], ...          % de 41 à 52
                    'timeFlag', [], ...          % 53
                    'cprFlag', [], ...           % 54
                    'latitude', [], ...          % de 55 à 71
                    'longitude', [], ...         % de 72 à 88
                    'trajectoire', [] );         % matrice des anciennes (latitude ; longitude) 
         
                
                
vecteur = load('adsb_msgs.mat');

%% initialisation 
val_nb_trame = length(vecteur.adsb_msgs(1,:));
registre_total = registre;


%% identification trame
for i=1:val_nb_trame
    vecteur_int = vecteur.adsb_msgs(:,i); % oon récupere le premier message pour test
    [outdata, Error] = detect(CRC, vecteur_int);
    vecteur_int = vecteur_int.';
    registre  =  bit2registre(vecteur_int,registre,Error);
    registre_total = [registre registre];
    
end

registre = registre_total(1);


trajectoire_y = registre(1).trajectoire(:,1);  
trajectoire_x = registre(1).trajectoire(:,2); % probleme longitude 

plot(x,y);


