%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

%% 

registre = struct ( 'adresse', [], ...           % de 9 à 32   
                    'format', [], ...            % de 1 à 5
                    'type', [], ...              % de 33 à 38
                    'nom', [], ...               % 
                    'altitude', [], ...          % de 41 à 52
                    'timeFlag', [], ...          % 53
                    'cprFlag', [], ...           % 54
                    'latitude', [], ...          % de 55 à 71
                    'longitude', [], ...         % de 72 à 88
                    'trajectoire', [] );         % 
               
