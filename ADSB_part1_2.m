%% Mathieu BROCHET_ Elsa DRONET
clear all;
close all;
clc;
%% Initialisation des variables
Fp = 1.09*10^6; %fréquence porteuse
Fe = 20*10^6;
Te = 1/Fe;
Ts = 1*10^(-6);
Ds = 1/Ts;
moy_fft = 100;
Fse = Ts/Te; % 20 échantillons
NFFT = 1000; % nombre de point par fft
Nb = 5; % nombre de bits % nombre de FFT

B = randi([0,1],1,NFFT*Nb);
po=zeros(1,Fse); % generation de po en echantillonnant au rythme Te
p1=zeros(1,Fse);
pk=zeros(NFFT*Nb,Fse);
for i=Fse/2+1:Fse
   po(i)=1;
end
for i=1:Fse/2
   p1(i)=1;
end
for k=1:NFFT*Nb
    if B(k)==0
       pk(k,:)=po;
    else
       pk(k,:)=p1;
    end
end
sl = reshape(pk.',1,[]); 
[DSP] = Mon_Welch(sl,NFFT); % dsp experimentale
%% affichage de la DSP


f = linspace(-Fe/2,Fe/2,NFFT);

figure(1);
semilogy(f,DSP);
title('Densite spectrale de puissance experimentale de Sl');
xlabel('frequence');
ylabel('Amplitude de Sl');


%% calcul DSP théorique

%  dirac = zeros(1,256);
%  dirac(128) = 0.0625;
 DSP_th = Ds^2/2 * (sinc(f/2).^2).*(sin(pi*f/2).^2); %DSP theorique
 DSP_th(NFFT/2+1) = DSP_th(NFFT/2+1)+Ds/4;
 hold on;
 grid on;

 
 
 
 %% affichage DSP théorique 
semilogy(f,DSP_th*10000);
%  plot(log(DSP_th));
 title('Densité spectrale de puissance théorique de Sl');
 xlabel('fréquence');
 ylabel('Amplitude de Sl');

