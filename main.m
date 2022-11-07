%Trabalho 5 ->PDS - FFT%

%Funções implementadas:
%[Y,ws] = MyDFT(X,Fs);         %DFT Forma Direta
%[Y] = MyFFT_DecFreq(X);       %FFT Dizimação na Frequência

%06 - Crie um sinal (2000) pontos aleatórios somado a três senoides (15Hz,
%45 e 70Hz). Compare os resultados (espectro de frequência e fase) das
%saídas das funções implementadas MyDFT, MyFFT_DecFreq e a
%função fft do Matlab. Encontre o erro quadrático médio entre as rotinas.

fs = 200;                       %Frequência de amostragem de 200 Hz.
t = 0:1/fs:10-1/fs;             %Vetor de Tempo com 2000 amostras.

%Sinal de Entrada: Sinal aleatório 2000 pontos + senoide 15Hz + senoide
%45Hz + senoide 70Hz:

X = sin(2*pi*15*t) + sin(2*pi*45*t) + sin(2*pi*70*t) + randn(1,2000);

%Figura 1 - Sinal de Entrada em função temporal
figure(1)
N = 1:1:length(X);
plot(N,X)
grid on;
title('Sinal de Entrada Temporal - Cenário 01 (Frequência de Amostragem de 200Hz)')
xlabel('Amostras [n]');
ylabel('Amplitude');

%Transformada Rápida MATLAB:
tic
Y1 = fft(X,2048);
T1 = toc;
%Transformada MyDFT Implementada:
tic
[Y2,ws] = MyDFT(X,200);
T2 = toc;

%Transformada My_FFT_DecFreq Implementada:
tic
Y3 = MyFFT_DecFreq(X);
T3 = toc;

%Figura 2 - Comparação Entre Magnitudes das Funções Implementadas:
figure(2)
subplot(3,1,1)
plot(ws,abs(Y1));
grid on;
title('Amplitude do Módulo da função fft do MATLAB');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');

subplot(3,1,2)
plot(ws,abs(Y2),'r');
grid on;
title('Amplitude do Módulo da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');



subplot(3,1,3)
plot(ws,abs(Y3),'k');
grid on;
title('Amplitude do Módulo da função MyFFT_ DecFreq');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');

%Figura 3 - Comparação entre as amplitudes de todas as funções:
figure(3)
plot(ws,abs(Y1));
grid on
hold on
plot(ws,abs(Y2),'r');
hold on
plot(ws,abs(Y3),'k');
hold on
title('Comparação entre Amplitudes do Módulo das FFTS');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem


%Figura 4 - Comparação entre Fases das FFT's Implementadas:
figure(4)
subplot(3,1,1)

plot(ws,unwrap(angle(Y1)));
grid on;
title('Fase Desenrolada da função fft do MATLAB');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');

subplot(3,1,2)
plot(ws,unwrap(angle(Y2)),'r');
grid on;
title('Fase Desenrolada da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');



subplot(3,1,3)
plot(ws,unwrap(angle(Y3)),'k');
grid on;
title('Fase Desenrolada da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');


%Figura 5 - Comparação entre as fases de todas as funções:
figure(5)
plot(ws,unwrap(angle(Y1)));
grid on
hold on
plot(ws,unwrap(angle(Y2)),'r');
hold on
plot(ws,unwrap(angle(Y3)),'k');
hold on

title('Comparação entre as Fases Desenroladas das FFTS');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem


%Figuras - Erro Entre fft e outros sinais
for i=1:length(Y1)
   %Erro entre fft e DFT:
   ERRO1(i) = Y1(i) - Y2(i);
  
   %Erro entre fft e FFT_DecFreq:
   ERRO3(i) = Y1(i) - Y3(i);
end

%Figura 6 - Comparação entre fft e MyDFT
Naux = 1:1:length(Y1);
figure(6) 
plot(Naux,ERRO1,'b')
grid on;
title('Erro por Amostra Cenário 01 (fft MATLAB - MyDFT Implementada)');
xlabel('Amostras [n]');
ylabel('Módulo do Erro');
axis([0 2048 -4e-10 5e-10]);
legend('fft() - MyDFT()') % inserir legenda, na ordem




%Figura 7 - Comparação entre fft e MyFFT_DecFreq
figure(7)
plot(Naux,ERRO3,'b')
grid on;
title('Erro por Amostra Cenário 01 (fft MATLAB - MyFFTDecFreq Implementada)');
xlabel('Amostras [n]');
ylabel('Módulo do Erro');
legend('fft() - MyFFTDecFreq()') % inserir legenda, na ordem
axis([0 2048 -4e-13 10e-13]);

%Computando o erro quadrático médio entre fft e MyDFT:
ERRO1QD = mean(sum((abs(Y1) - abs(Y2)).^2));


%Computando o erro quadrático médio entre fft e MyFFT_DecFreq:
ERRO3QD = mean(sum((abs(Y1) - abs(Y3)).^2));



%Computando o erro quadrático médio entre MyDFT e MyFFT_DecFreq:
ERRO5QD = mean(sum((abs(Y2) - abs(Y3)).^2));




%02 - Crie um sinal aleatório somado a duas senoides (10Hz e 25Hz) com fs =
%512Hz para N(número de pontos) = 2,4,8,16,32,64,128,256,512,1024 e 2048.
%Com estes sinais encontre os espectros (fase e frequência) utilizando as
%funções MyDFT, MyFFT e a função fft do MATLAB. Preencha a tabela:
fs1 = 512;

%Número de pontos = 2:
N = 2;
TP2 = 0:1/fs1:((N/fs1)-(1/fs1));
SX2 = randn(1,N) + sin(2*pi*10*TP2) + sin(2*pi*25*TP2);

%fft N=2:
tic
YFFT72 = fft(SX2);
MYFFT72 = toc;
%MyDFT N=2:
tic
[YDFT72,w72] = MyDFT(SX2,fs);
MYDFT72 = toc;

%MyFFT_DecFreq N=2:
tic
YDF72 = MyFFT_DecFreq(SX2);
MYDF72 = toc;

%Número de pontos = 4;
N = 4;
TP4 = 0:1/fs1:((N/fs1)-(1/fs1));
SX4 = randn(1,N) + sin(2*pi*10*TP4) + sin(2*pi*25*TP4);

%fft N=4:
tic
YFFT74 = fft(SX4);
MYFFT74 = toc;
%MyDFT N=4:
tic
[YDFT74,w74] = MyDFT(SX4,fs);
MYDFT74 = toc;

%MyFFT_DecFreq N=4:
tic
YDF74 = MyFFT_DecFreq(SX4);
MYDF74 = toc;


%Número de pontos = 8 ******; 
N = 8;
TP8 = 0:1/fs1:((N/fs1)-(1/fs1));
SX8 = randn(1,N) + sin(2*pi*10*TP8) + sin(2*pi*25*TP8);

%fft N=8:
tic
YFFT78 = fft(SX8);
MYFFT78 = toc;
%MyDFT N=8:
tic
[YDFT78,w78] = MyDFT(SX8,fs);
MYDFT78 = toc;
 
%MyFFT_DecFreq N=8:
tic
YDF78 = MyFFT_DecFreq(SX8);
MYDF78 = toc;


%Número de pontos = 16;
N = 16;
TP16 = 0:1/fs1:((N/fs1)-(1/fs1));
SX16 = randn(1,N) + sin(2*pi*10*TP16) + sin(2*pi*25*TP16);

%fft N=16:
tic
YFFT716 = fft(SX16);
MYFFT716 = toc;
%MyDFT N=16:
tic
[YDFT716,w716] = MyDFT(SX16,fs);
MYDFT716 = toc;
 
%MyFFT_DecFreq N=16:
tic
YDF716 = MyFFT_DecFreq(SX16);
MYDF716 = toc;



%Número de pontos = 32;
N = 32;
TP32 = 0:1/fs1:((N/fs1)-(1/fs1));
SX32 = randn(1,N) + sin(2*pi*10*TP32) + sin(2*pi*25*TP32);

%fft N=32:
tic
YFFT732 = fft(SX32);
MYFFT732 = toc;
%MyDFT N=32:
tic
[YDFT732,w732] = MyDFT(SX32,fs);
MYDFT732 = toc;

%MyFFT_DecFreq N=32:
tic
YDF732 = MyFFT_DecFreq(SX32);
MYDF732 = toc;


figure(8)
subplot(3,1,1)
plot(w732,abs(YFFT732));
grid on;
title('Amplitude do Módulo da função fft do MATLAB (N=32)');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -inf inf]);

subplot(3,1,2)
plot(w732,abs(YDFT732),'r');
grid on;
title('Amplitude do Módulo da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w732,abs(YDF732),'k');
grid on;
title('Amplitude do Módulo da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

%Figura 10 - Comparação entre as amplitudes de todas as funções:
figure(10)
plot(w732,abs(YFFT732));
grid on
hold on
plot(w732,abs(YDFT732),'r');
hold on
plot(w732,abs(YDF732),'k');
hold on

title('Comparação entre Amplitudes do Módulo das FFTS com N=32');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Figura 11 - Comparação entre Fases das FFT's Implementadas:
figure(11)
subplot(3,1,1)

plot(w732,unwrap(angle(YFFT732)));
grid on;
title('Fase Desenrolada da função fft do MATLAB (N=32)');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w732,unwrap(angle(YDFT732)),'r');
grid on;
title('Fase Desenrolada da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);


subplot(3,1,3)
plot(w732,unwrap(angle(YDF732)),'k');
grid on;
title('Fase Desenrolada da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

%Figura 12 - Comparação entre as fases de todas as funções:
figure(12)
plot(w732,unwrap(angle(YFFT732)));
grid on
hold on
plot(w732,unwrap(angle(YDFT732)),'r');
hold on
plot(w732,unwrap(angle(YDF732)),'k');
hold on
title('Comparação entre as Fases Desenroladas das FFTS com N=32');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Número de pontos = 64;
N = 64;
TP64 = 0:1/fs1:((N/fs1)-(1/fs1));
SX64 = randn(1,N) + sin(2*pi*10*TP64) + sin(2*pi*25*TP64);

%fft N=64:
tic
YFFT764 = fft(SX64);
MYFFT764 = toc;
%MyDFT N=64:
tic
[YDFT764,w764] = MyDFT(SX64,fs);
MYDFT764 = toc;

%MyFFT_DecFreq N=64:
tic
YDF764 = MyFFT_DecFreq(SX64);
MYDF764 = toc;


%Número de pontos = 128;
N = 128;
TP128 = 0:1/fs1:((N/fs1)-(1/fs1));
SX128 = randn(1,N) + sin(2*pi*10*TP128) + sin(2*pi*25*TP128);

%fft N=128:
tic
YFFT7128 = fft(SX128);
MYFFT7128 = toc;
%MyDFT N=128:
tic
[YDFT7128,w7128] = MyDFT(SX128,fs);
MYDFT7128 = toc;

%MyFFT_DecFreq N=128:
tic
YDF7128 = MyFFT_DecFreq(SX128);
MYDF7128 = toc;



%Número de pontos = 256;
N = 256;
TP256 = 0:1/fs1:((N/fs1)-(1/fs1));
SX256 = randn(1,N) + sin(2*pi*10*TP256) + sin(2*pi*25*TP256);

%fft N=256:
tic
YFFT7256 = fft(SX256);
MYFFT7256 = toc;
%MyDFT N=256:
tic
[YDFT7256,w7256] = MyDFT(SX256,fs);
MYDFT7256 = toc;

%MyFFT_DecFreq N=256:
tic
YDF7256 = MyFFT_DecFreq(SX256);
MYDF7256 = toc;

figure(13)
subplot(3,1,1)
plot(w7256,abs(YFFT7256));
grid on;
title('Amplitude do Módulo da função fft do MATLAB (N=256)');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w7256,abs(YDFT7256),'r');
grid on;
title('Amplitude do Módulo da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w7256,abs(YDF7256),'k');
grid on;
title('Amplitude do Módulo da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

figure(14)
plot(w7256,abs(YFFT7256));
grid on
hold on
plot(w7256,abs(YDFT7256),'r');
hold on
plot(w7256,abs(YDF7256),'k');
hold on
title('Comparação entre Amplitudes do Módulo das FFTS com N=256');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Figura 15 - Comparação entre Fases das FFT's Implementadas:
figure(15)
subplot(3,1,1)

plot(w7256,unwrap(angle(YFFT7256)));
grid on;
    title('Fase Desenrolada da função fft do MATLAB (N=256)');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w7256,unwrap(angle(YDFT7256)),'r');
grid on;
title('Fase Desenrolada da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);


subplot(3,1,3)
plot(w7256,unwrap(angle(YDF7256)),'k');
grid on;
title('Fase Desenrolada da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

%Figura 16 - Comparação entre as fases de todas as funções:
figure(16)
plot(w7256,unwrap(angle(YFFT7256)));
grid on
hold on
plot(w7256,unwrap(angle(YDFT7256)),'r');
hold on
plot(w7256,unwrap(angle(YDF7256)),'k');
hold on

title('Comparação entre as Fases Desenroladas das FFTS com N=256');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);


%Número de pontos = 512;
N = 512;
TP512 = 0:1/fs1:((N/fs1)-(1/fs1));
SX512 = randn(1,N) + sin(2*pi*10*TP512) + sin(2*pi*25*TP512);

%fft N=512:
tic
YFFT7512 = fft(SX512);
MYFFT7512 = toc;
%MyDFT N=512:
tic
[YDFT7512,w7512] = MyDFT(SX512,fs);
MYDFT7512 = toc;

%MyFFT_DecFreq N=512:
tic
YDF7512 = MyFFT_DecFreq(SX512);
MYDF7512 = toc;


%Número de pontos = 1024 ******;
N = 1024;
TP1024 = 0:1/fs1:((N/fs1)-(1/fs1));
SX1024 = randn(1,N) + sin(2*pi*10*TP1024) + sin(2*pi*25*TP1024);

%fft N=1024:
tic
YFFT71024 = fft(SX1024);
MYFFT71024 = toc;
%MyDFT N=1024:
tic
[YDFT71024,w71024] = MyDFT(SX1024,fs);
MYDFT71024 = toc;

%MyFFT_DecFreq N=1024:
tic
YDF71024 = MyFFT_DecFreq(SX1024);
MYDF71024 = toc;


figure(17)
subplot(3,1,1)
plot(w71024,abs(YFFT71024));
grid on;
title('Amplitude do Módulo da função fft do MATLAB (N=1024)');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w71024,abs(YDFT71024),'r');
grid on;
title('Amplitude do Módulo da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w71024,abs(YDF71024),'k');
grid on;
title('Amplitude do Módulo da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

figure(18)
plot(w71024,abs(YFFT71024));
grid on
hold on
plot(w71024,abs(YDFT71024),'r');
hold on
plot(w71024,abs(YDF71024),'k');
hold on

title('Comparação entre Amplitudes do Módulo das FFTS com N=1024');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Figura 19 - Comparação entre Fases das FFT's Implementadas:
figure(19)
subplot(3,1,1)
plot(w71024,unwrap(angle(YFFT71024)));
grid on;
title('Fase Desenrolada da função fft do MATLAB (N=1024)');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w71024,unwrap(angle(YDFT71024)),'r');
grid on;
title('Fase Desenrolada da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w71024,unwrap(angle(YDF71024)),'k');
grid on;
title('Fase Desenrolada da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

%Figura 20 - Comparação entre as fases de todas as funções:
figure(20)
plot(w71024,unwrap(angle(YFFT71024)));
grid on
hold on
plot(w71024,unwrap(angle(YDFT71024)),'r');
hold on
plot(w71024,unwrap(angle(YDF71024)),'k');
hold on
title('Comparação entre as Fases Desenroladas das FFTS com N=1024');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Número de pontos = 2048;
N = 2048;
TP2048 = 0:1/fs1:((N/fs1)-(1/fs1));
SX2048 = randn(1,N) + sin(2*pi*10*TP2048) + sin(2*pi*25*TP2048);

%fft N=2048:
tic
YFFT72048 = fft(SX2048);
MYFFT72048 = toc;
%MyDFT N=2048:
tic
[YDFT72048,w72048] = MyDFT(SX2048,fs);
MYDFT72048 = toc;
 
%MyFFT_DecFreq N=2048:
tic
YDF72048 = MyFFT_DecFreq(SX2048);
MYDF72048 = toc;

figure(21)
subplot(3,1,1)
plot(w72048,abs(YFFT72048));
grid on;
title('Amplitude do Módulo da função fft do MATLAB (N=2048)');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w72048,abs(YDFT72048),'r');
grid on;
title('Amplitude do Módulo da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w72048,abs(YDF72048),'k');
grid on;
title('Amplitude do Módulo da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
axis([0 200 -Inf Inf]);

figure(22)
plot(w72048,abs(YFFT72048));
grid on
hold on
plot(w72048,abs(YDFT72048),'r');
hold on
plot(w72048,abs(YDF72048),'k');
hold on

title('Comparação entre Amplitudes do Módulo das FFTS com N=2048');
xlabel('Frequências (Hz)');
ylabel('|X(e^{j\omega})|');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);

%Figura 23 - Comparação entre Fases das FFT's Implementadas:
figure(23)
subplot(3,1,1)
plot(w72048,unwrap(angle(YFFT72048)));
grid on;
title('Fase Desenrolada da função fft do MATLAB (N=2048)');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,2)
plot(w72048,unwrap(angle(YDFT72048)),'r');
grid on;
title('Fase Desenrolada da função MyDFT Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

subplot(3,1,3)
plot(w72048,unwrap(angle(YDF72048)),'k');
grid on;
title('Fase Desenrolada da função MyFFT_ DecFreq Desenvolvida');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
axis([0 200 -Inf Inf]);

%Figura 24 - Comparação entre as fases de todas as funções:
figure(24)
plot(w72048,unwrap(angle(YFFT72048)));
grid on
hold on
plot(w72048,unwrap(angle(YDFT72048)),'r');
hold on
plot(w72048,unwrap(angle(YDF72048)),'k');
hold on

title('Comparação entre as Fases Desenroladas das FFTS com N=2048');
xlabel('Frequências (Hz)');
ylabel('arg[X(e^{jw}]');
legend('fft()','MyDFT()','MyFFT__DecFreq()') % inserir legenda, na ordem
axis([0 200 -Inf Inf]);


%COLUNA 1 DA TABELA A SER PREENCHIDA COM OS TEMPOS DA MYDFT:
COLUNA1 = [MYDFT72 MYDFT74 MYDFT78 MYDFT716 MYDFT732 MYDFT764 MYDFT7128 MYDFT7256 MYDFT7512 MYDFT71024 MYDFT72048];

%COLUNA 2 DA TABELA A SER PREENCHIDA COM OS TEMPOS DA MYFFT_DECFREQ:
COLUNA2 = [MYDF72 MYDF74 MYDF78 MYDF716 MYDF732 MYDF764 MYDF7128 MYDF7256 MYDF7512 MYDF71024 MYDF72048];

%COLUNA 3 DA TABELA A SER PREENCHIDA COM OS TEMPOS DA FFT DO MATLAB:
COLUNA3 = [MYFFT72 MYFFT74 MYFFT78 MYFFT716 MYFFT732 MYFFT764 MYFFT7128 MYFFT7256 MYFFT7512 MYFFT71024 MYFFT72048];


%ERROS QUADRÁTICOS MÉDIOS:

%fftxMyFFT_DecFreq
ER12 = mean(sum((abs(YFFT72) - abs(YDF72)).^2));
ER13 = mean(sum((abs(YFFT74) - abs(YDF74)).^2));
ER14 = mean(sum((abs(YFFT78) - abs(YDF78)).^2));
ER15 = mean(sum((abs(YFFT716) - abs(YDF716)).^2));
ER16 = mean(sum((abs(YFFT732) - abs(YDF732)).^2));
ER17 = mean(sum((abs(YFFT764) - abs(YDF764)).^2));
ER18 = mean(sum((abs(YFFT7128) - abs(YDF7128)).^2));
ER19 = mean(sum((abs(YFFT7256) - abs(YDF7256)).^2));
ER20 = mean(sum((abs(YFFT7512) - abs(YDF7512)).^2));
ER21 = mean(sum((abs(YFFT71024) - abs(YDF71024)).^2));
ER22 = mean(sum((abs(YFFT72048) - abs(YDF72048)).^2));

COLUNA4 = [ER12 ER13 ER14 ER15 ER16 ER17 ER18 ER19 ER20 ER21 ER22];

%Gráfico Tempo Computacional em Função do N:
figure(25)
N = [1 2 3 4 5 6 7 8 9 10 11];
plot(N,COLUNA1,'b')
grid on;
ylabel('Tempo Computacional (s)');
xlabel('Número de Amostras');
title('Tempo Computacional em Função do Número de Amostras')
hold on
plot(N,COLUNA2,'r')
hold on
plot(N,COLUNA3,'k')
hold on
xticklabels({'2^1','2^2','2^3','2^4','2^5','2^6','2^7','2^8','2^9','2^{10}','2^{11}'});
legend('MyDFT()','MyFFT__DecFreq()','fft do MATLAB') % inserir legenda, na ordem