%% Projeto de Processamento Digital de Sinais - UFRN
% Método: Sobreposição e Soma (Overlap-Add)
% Prof. Felipe Silveira
clear all; close all; clc;
%% ================== PASSO 1: VALIDAÇÃO ==================
disp('========== PASSO 1: VALIDAÇÃO DO ALGORITMO ==========');
% Parâmetros para validação
N = 512; % Número de pontos da FFT (pode usar 1024 também)
M_val = 150; % Número de amostras da resposta ao impulso h[n] PARA VALIDAÇÃO
L = N - M_val + 1; % Comprimento de cada bloco
Lx = round(15.3 * L); % Comprimento do sinal de entrada (~15.3*L)
disp(['Parâmetros de validação: N=', num2str(N), ', M=', num2str(M_val), ', L=',
num2str(L)]);
disp(['Comprimento do sinal de entrada: ', num2str(Lx), ' amostras (≈',
num2str(Lx/L, '%.1f'), '*L)']);
% Gerar sinais aleatórios para teste
x = randn(1, Lx); % Sinal de entrada aleatório
h_val = randn(1, M_val); % Filtro FIR aleatório para validação
% Convolução usando Overlap-Add (nossa implementação)
tic;
y_overlap = overlap_add(x, h_val, N);
tempo_overlap = toc;
% Convolução no tempo (para validação)
tic;
y_conv = conv(x, h_val);
tempo_conv = toc;
% Comparação dos resultados
erro = max(abs(y_overlap - y_conv));
disp(['Erro máximo entre overlap-add e convolução no tempo: ', num2str(erro)])];
