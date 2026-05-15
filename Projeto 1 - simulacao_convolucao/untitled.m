Fs = 12000;               % Frequência de Amostragem (Hz)
Ts = 1 / Fs;              % Período de Amostragem (s)
M = 275;                  % Ordem do Filtro
N = M + 1;                % Comprimento do Filtro
alfa = M / 2;             % Atraso do Filtro
% Frequência de Corte Ideal (radianos)
Wc = 0.813 * pi;
% Vetor de tempo discreto
n = 0:M;
% 1. Cálculo da Resposta ao Impulso Ideal (hd[n])
hd_n = sin(Wc * (n - alfa)) ./ (pi * (n - alfa));
hd_n(n == alfa) = Wc / pi;  % Corrige a indeterminação em n = alfa
% 2. Função Janela (Blackman)
w_n = 0.42 - 0.5 * cos(2*pi*n / M) + 0.08 * cos(4*pi*n / M);
% 3. Resposta ao Impulso Final do Filtro (h[n])
h_coef = hd_n .* w_n;
% 4. Resposta em Frequência (Magnitude e Fase)
N_FFT = 2048;
H_w = fft(h_coef, N_FFT);
% Vetores de Frequência
w_rad = linspace(0, 2*pi, N_FFT);
w_norm = w_rad / pi;
% Magnitude e fase (somente metade positiva)
H_mag_dB = 20 * log10(abs(H_w(1:N_FFT/2)));
H_fase = unwrap(angle(H_w(1:N_FFT/2)));
w_norm_half = w_norm(1:N_FFT/2);
% Resposta ao Impulso
figure(1);
t_h = n * Ts;
stem(t_h * 1000, h_coef, 'filled', LineWidth=1);
title('Resposta ao Impulso h[n] (FIR)');
xlabel('Tempo (ms)');
ylabel('Amplitude');
grid on;

% Resposta em Frequência
figure(2);
subplot(2,1,1);
plot(w_norm_half, H_mag_dB);
title('Resposta em Magnitude |H(e^{j\omega})|');
xlabel('\omega (radianos/\pi)');
ylabel('Magnitude (dB)');
grid on;
subplot(2,1,2);
plot(w_norm_half, H_fase);
title('Resposta de Fase \phi(\omega)');
xlabel('\omega (radianos/\pi)');
ylabel('Fase (radianos)');
grid on;

% Aplicando plotspec ao impulso do filtro
figure(3);
plotspec(h_coef, Ts);
sgtitle('Espectro da Resposta ao Impulso h[n] - usando função plotspec');

function plotspec(x, Ts)
N=length(x);                               
t=Ts*(1:N);                                
ssf=(-N/2:N/2-1)/(Ts*N);                   
fx=fft(x(1:N));                            
fxs=fftshift(fx);                          
subplot(2,1,1), plot(t,x)                  
xlabel('seconds'); ylabel('amplitude')     
subplot(2,1,2), plot(ssf,abs(fxs))  
xlabel('frequency'); ylabel('magnitude')   
end
% length of the signal x
% define a time vector 
% frequency vector
% do DFT/FFT
% shift it for plotting
% plot the waveform
% label the axes
% plot magnitude spectrum
% label the axes