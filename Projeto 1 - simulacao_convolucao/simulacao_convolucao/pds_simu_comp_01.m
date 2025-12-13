% DISCENTES: 
% HANNA VITÓRIA DE OLIVEIRA SILVA
% LUCILA GABRIELA GOMES COSTA
% MARIA LUIZA MELO SILVA
% =========================
% A) LER A RESPOSTA AO IMPULSO
% =========================
[y, Fs] = audioread("church_audio.wav");
impulse = y(:,1);
sound(y,Fs);

% =========================
% B) GRAVAR UM NOVO AÚDIO
% =========================
voz = audiorecorder(Fs, 16, 1);
disp("Vai começar a gravação")
recordblocking(voz, 3);
disp("Acabou");

audio_voz = getaudiodata(voz);
%sound(audio_voz, Fs);

% =========================
%  C) APLICAR CONVOLUÇÃO
% =========================
conv_result = conv(audio_voz, impulse);
disp("Reproduzindo audio com aplicação da convolução");
sound(conv_result, Fs);

% =========================
% D) SALVAR O RESULTADO EM UM ARQUIVO
% =========================
audiowrite("voz_na_igreja.wav", conv_result, Fs);
disp("Deu certo");