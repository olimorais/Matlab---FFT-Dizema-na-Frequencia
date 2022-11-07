%Esta fun��o � respons�vel por realizar a transformada discreta de Fourier
%com dizima��o na frequ�ncia. A fun��o � respons�vel por analisar o n�mero 
%de est�gios de c�lculo e calcular a transformada de Fourier 
%com base nestes est�gios. Os par�metros de entrada ser�o o 
%sinal original a ser transformado (X) e o par�metro 
%de sa�da ser� o sinal transformado (FFTDF).

function [FFTDF] = MyFFT_DecFreq(X)

%An�lise do sinal de entrada:
%A primeira an�lise do sinal de entrada � muito importante pois a dizima��o
%no tempo s� � feita a partir de sinais multiplos de 2, ou seja, o sinal de
%entrada deve ser uma pot�ncia de 2 para a dizima��o ser realizada. Desta
%maneira ser� verificado se o sinal � ou n�o uma pot�ncia de 2 e em caso
%negativo ser� utilizado o mecanismo de preenchimento de zeros 
%(zero padding) afim de tornar o sinal uma pot�ncia de 2.

N = length(X);       %Vari�vel utilizada para guardar o tamanho 
%do sinal de entrada.
NP = ceil(log2(N));  %O comando ceil retorna a pot�ncia 
%de 2 mais pr�xima do valor de entrada atual. 
%Por exemplo, um sinal de 2000 pontos, a pr�xima
%pot�ncia de 2 seria 2048 o que daria 2^11 e ent�o NP seria 11.

if (2^NP ~= N)
    X = [X zeros(1,(2^NP)- N)];% Preenchimento com zeros at� chegar a 2^NP.
end

N = length(X); %Agora o sinal j� � uma pot�ncia de 2 e poder� ser utilizado
%o mecanismo de dizima��o no tempo.

%DIZIMA��O NA FREQU�NCIA:

NE = log2(N); %A vari�vel NE � respons�vel por contar o n�mero de est�gios
%de c�lculo que ser�o utilizados para resolu��o do problema. Como exemplo,
%um sinal de 2048 pontos pode ser dividido 11 vezes, ou seja, 11 est�gios
%de c�lculo ser�o utilizados.

VE = 1:1:NE; %Como a dizima��o na frequ�ncia ser� realizada na ordem normal,
%o primeiro est�gio ser� o �ltimo e assim sucessivamente, logo � necess�rio
%inverter a ordem dos est�gios, assim:
VE = wrev(VE);

k = 0:1:N-1;%Vari�vel utilizada para determina��o dos 
%�ndices dos coeficientes.
Wn = exp(-1j*2*pi*k/N); % Coeficientes Wn utilizados na FFT.


%EXECU��O DO FLUXO EM BORBOLETA

for n=VE:-1:1 %La�o de repeti��o utilizado 
    %para contagem dos est�gios de c�lculo.
    
    %A parcela 2^n corresponde � amostra envolvida em cada est�gio. No caso
    %em que NE = 1 as amostras s�o feitas de 2 em 2, e assim sucessivamente.
    
    %A parcela N/2^n corresponde ao expoente dos coeficientes Wn utilizados.
    %Se N/2^n = 10 ent�o os coeficientes ser�o calculados W^0 W^10 W^20, e
    %assim sucessivamente.
    
    WnAUX=Wn([1:(N/2^n):(N/2)]);
    %Percorrer os coeficientes ao passo de N/2^n que � dado pelos
    %coeficientes.
    
    for k=1:(N/2^n)
        
        AUX = X(k*2^n - 2^n+1:k*2^n); %Blocos de Dados em forma matricial.
        AUXUP = AUX(1:end/2);         %Porcao superior da matriz de dados.
        AUXDOWN = AUX((end/2)+1:end); %Porcao inferior da matriz de dados.
        
        %Operacao Borboleta entre porcao superior e inferior:
        RUP = AUXUP + AUXDOWN;
        
        %Operacao Borboleta entre porcao inferior e superior:
        RDOWN = (AUXUP - AUXDOWN).*WnAUX;
                
        %Resultado da operacao local:
        X(k*2^n - 2^n+1:k*2^n)=[RUP RDOWN];
    end
end
%Para o c�lculo da FFT com dizima��o na frequ�ncia, 
%a entrada do sinal ser� na
%ordem NORMAL e a sa�da na ordem BIT-REVERSA. Logo:

FFTDF = bitrevorder(X);  %Saida na ordem BIT-REVERSA

end