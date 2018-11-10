%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

p_g = [1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 0 0 0 0 0 1 0 0 1]; %polynome du CRC 
CRC = crc.detector(p_g); % creation du crc detector  % partie décodage 


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
carte  = (imread('fond.jpg'));

%% initialisation 
val_nb_trame = length(vecteur.adsb_msgs(1,:));
registre_total = registre;


%% identification trame
for i=1:val_nb_trame
    vecteur_int = vecteur.adsb_msgs(:,i); % oon récupere le premier message pour test
    [outdata, Error] = detect(CRC, vecteur_int);
    vecteur_int = vecteur_int.';
    registre_new  = bit2registre(vecteur_int,registre,Error);
    registre_total = [registre_total registre_new];
end


figure(1);
imshow(carte);


