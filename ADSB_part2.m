%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

%% Structure de registre

registre = struct ( 'adresse', [], ...           % de 9 � 32   
                    'format', [], ...            % de 1 � 5
                    'type', [], ...              % de 33 � 38
                    'nom', [], ...               % adresse
                    'altitude', [], ...          % de 41 � 52
                    'timeFlag', [], ...          % 53
                    'cprFlag', [], ...           % 54
                    'latitude', [], ...          % de 55 � 71
                    'longitude', [], ...         % de 72 � 88
                    'trajectoire', [] );         % matrice des anciennes (latitude ; longitude) 
               
vecteur = [ 0 1 0 0 0 0 1 1 0 0 0 1 1 1 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1];
decodage(vecteur)