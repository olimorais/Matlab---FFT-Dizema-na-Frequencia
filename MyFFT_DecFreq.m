%Esta função é responsável por realizar a transformada discreta de Fourier
%com dizimação na frequência. A função é responsável por analisar o número 
%de estágios de cálculo e calcular a transformada de Fourier 
%com base nestes estágios. Os parâmetros de entrada serão o 
%sinal original a ser transformado (X) e o parâmetro 
%de saída será o sinal transformado (FFTDF).

function [FFTDF] = MyFFT_DecFreq(X)

%Análise do sinal de entrada:
%A primeira análise do sinal de entrada é muito importante pois a dizimação
%no tempo só é feita a partir de sinais multiplos de 2, ou seja, o sinal de
%entrada deve ser uma potência de 2 para a dizimação ser realizada. Desta
%maneira será verificado se o sinal é ou não uma potência de 2 e em caso
%negativo será utilizado o mecanismo de preenchimento de zeros 
%(zero padding) afim de tornar o sinal uma potência de 2.

N = length(X);       %Variável utilizada para guardar o tamanho 
%do sinal de entrada.
NP = ceil(log2(N));  %O comando ceil retorna a potência 
%de 2 mais próxima do valor de entrada atual. 
%Por exemplo, um sinal de 2000 pontos, a próxima
%potência de 2 seria 2048 o que daria 2^11 e então NP seria 11.

if (2^NP ~= N)
    X = [X zeros(1,(2^NP)- N)];% Preenchimento com zeros até chegar a 2^NP.
end

N = length(X); %Agora o sinal já é uma potência de 2 e poderá ser utilizado
%o mecanismo de dizimação no tempo.

%DIZIMAÇÃO NA FREQUÊNCIA:

NE = log2(N); %A variável NE é responsável por contar o número de estágios
%de cálculo que serão utilizados para resolução do problema. Como exemplo,
%um sinal de 2048 pontos pode ser dividido 11 vezes, ou seja, 11 estágios
%de cálculo serão utilizados.

VE = 1:1:NE; %Como a dizimação na frequência será realizada na ordem normal,
%o primeiro estágio será o último e assim sucessivamente, logo é necessário
%inverter a ordem dos estágios, assim:
VE = wrev(VE);

k = 0:1:N-1;%Variável utilizada para determinação dos 
%índices dos coeficientes.
Wn = exp(-1j*2*pi*k/N); % Coeficientes Wn utilizados na FFT.


%EXECUÇÃO DO FLUXO EM BORBOLETA

for n=VE:-1:1 %Laço de repetição utilizado 
    %para contagem dos estágios de cálculo.
    
    %A parcela 2^n corresponde à amostra envolvida em cada estágio. No caso
    %em que NE = 1 as amostras são feitas de 2 em 2, e assim sucessivamente.
    
    %A parcela N/2^n corresponde ao expoente dos coeficientes Wn utilizados.
    %Se N/2^n = 10 então os coeficientes serão calculados W^0 W^10 W^20, e
    %assim sucessivamente.
    
    WnAUX=Wn([1:(N/2^n):(N/2)]);
    %Percorrer os coeficientes ao passo de N/2^n que é dado pelos
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
%Para o cálculo da FFT com dizimação na frequência, 
%a entrada do sinal será na
%ordem NORMAL e a saída na ordem BIT-REVERSA. Logo:

FFTDF = bitrevorder(X);  %Saida na ordem BIT-REVERSA

end