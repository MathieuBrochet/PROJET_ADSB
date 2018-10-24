%% Mathieu Brochet, Elsa Dronet


clear all; 
close all;
clc;

%% Initialisation 
Ts = 1*10^-6; % symbol period 

Nb = 5; % nb of symbols 
Fse = 20; %nb of samples
Te= Ts/Fse; % samples period
Fe=1/Te;
Sb = [1 0 0 1 0];

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
    if Sb(k)==0
        pk(k,:)=p0;
    else
        pk(k,:)=p1;
    end
end 


 Sl = reshape(pk.',1,[]);

 %affichage
figure(1);
plot(Sl);
title('Modulation PPM');
xlabel('Echantillonage Fse');
ylabel('Sl(t)');



%% Rl 

p =zeros(1,Fse);

for i=1:Fse/2 
    p(i) = 0.5;
    
end


for i=(Fse/2)+1:Fse 
    p(i) = -0.5;
    
end


Rl = conv(p,Sl);
Rl = Rl/Nb;

figure(2);
plot(Rl);
title('Convolution avec p');
xlabel('Echantillonnage Fse');
ylabel('Rl(t)');

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




