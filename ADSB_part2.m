%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

%% 

registre = struct ( 'adresse', [], ...           % de 9 � 32   
                    'format', [], ...            % de 1 � 5
                    'type', [], ...              % de 33 � 38
                    'nom', [], ...               % 
                    'altitude', [], ...          % de 41 � 52
                    'timeFlag', [], ...          % 53
                    'cprFlag', [], ...           % 54
                    'latitude', [], ...          % de 55 � 71
                    'longitude', [], ...         % de 72 � 88
                    'trajectoire', [] );         % 
               
