function [y] = Mon_Welch(x,NFFT)

y = [];
moy_fft = 100;
Ts = 1*10^(-6);
for i=1:moy_fft
    x1 = x((i-1)*NFFT+1:i*NFFT); % segmentation de 256
    y =[ y; fftshift(fft(x1))];% somme de toutes le fft
end

y = mean(abs(y).^2);  % moyennage des fft (DSP experimentale)
  
end

