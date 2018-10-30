

clear all; 
close all;
clc;

%% Initialisation 
Ts = 1*10^-6; % symbol period 
Nb = 1000000; % nb of symbols 
Fse = 20; %nb of samples
Te= Ts/Fse; % samples period
Fe=1/Te;
Sb =randi([0,1],1,Nb);


g=ones(1,Fse);% g√©n√©ration de g en √©chantillonnant au rythme Te
Eg = sum(g.^2); 
sigma = 1;
Eb_N0_db=linspace(0,10,11); % erreur binaire sur No en db 
Eb_N0 = 10.^(Eb_N0_db/10); %erreur binaire No
sigma2 = (sigma^2 * Eg) ./ (2*Eb_N0); % variance du bruit blanc

%% bruit blanc gaussien 
teb = zeros(1,length(sigma2));
for i=1:length(sigma2)
    ERROR = 0;
    counter = 0;
    while (ERROR < 100)
        counter = counter +1;
        nl = sqrt(sigma2(i)).*randn(1,Fse*Nb); %bruit 

%% PPM 

        Sl = zeros(1,Fse*Nb); %vector of Sl samples
        p0 = zeros(1,Fse); 
        p1 = zeros(1,Fse);

        for j=(Fse/2)+1:Fse
            p0(j)=1;
        end

        for j=1:Fse/2
            p1(j)=1;
        end
        pk = zeros(Nb,Fse);


        for k=1:Nb
            if Sb(k)==0
                pk(k,:)=p0;
            else
                pk(k,:)=p1;
            end
        end 


        Sl = reshape(pk.',1,[]) + nl; %ajout du bruit

 %affichage
% figure(1);
% plot(Sl);
% title('Modulation PPM');
% xlabel('Echantillonage Fse');
% ylabel('Sl(t)');



%% Rl 

        p =zeros(1,Fse);

        for j=1:Fse/2 
            p(j) = 0.5;
        end


        for j=(Fse/2)+1:Fse 
            p(j) = -0.5;
        end
       

        Rl = conv(p,Sl);
        Rl = Rl/Nb;

% figure(2);
% plot(Rl);
% title('Convolution avec p');
% xlabel('Echantillonnage Fse');
% ylabel('Rl(t)');

%% Echantillonage

        Rm = zeros(1,Nb);
        for j=1:Nb
            Rm(j) = Rl(j*Fse);
        end



    %% DÈcision 

        B = zeros(1,Nb); %vector of final bits
        for j=1:Nb
            if Rm(j) <0 
                B(j) = 1;
            else  
                B(j) = 0;
            end
        end




%% taux d'erreur binaire exp



            for j = 1:Nb
                if B(j) ~= Sb(j)
                    ERROR = ERROR + 1; %compteur d'erreurs 
                end
            end
        teb(i) = ERROR/(length(B)*counter);
    end 
end
        
%% taux d'erreur binaire theorique



    TEB_th =0.5*erfc(sqrt(Eb_N0));   % TEB th 
    
%%  superpostion TEB th et teb
figure(4);
semilogy(Eb_N0_db,TEB_th);
hold all;
semilogy(Eb_N0_db,teb);
grid on;
xlabel('rapport Eb/N0 en dB');
ylabel('TEB');
title('superposition du TEB avec la Pb thÈorique');
