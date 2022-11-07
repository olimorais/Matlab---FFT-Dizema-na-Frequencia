function [Y,ws] = MyDFT(X,fs)

N = length(X);            %N � correspondente ao n�mero de pontos do vetor de entrada.
NP = ceil(log2(N));  %O comando ceil retorna a pot�ncia de 2 mais pr�xima do
%valor de entrada atual. Por exemplo, um sinal de 2000 pontos, a pr�xima
%pot�ncia de 2 seria 2048 o que daria 2^11 e ent�o NP seria 11.

if (2^NP ~= N)
    X = [X zeros(1,(2^NP)- N)];  % Preenchimento com zeros at� chegar a 2^NP.
end

N = length(X);    %Agora o sinal j� � uma pot�ncia de 2 e poder� ser utilizado
%o mecanismo de dizima��o no tempo.

ws = 0:fs/N:fs-(fs/N);    

%Implementa��o da DFT via f�rmula:

for k=1:1:N      %Percorre os N valores do vetor de entrada para preencher as N posi��es do vetor de sa�da. 
    somaX = 0;
    for n=1:1:N  %Percorre os N valores do vetor de entrada para fazer as N multiplica��es pela exponencial
                 %e assim obter o valor correspondente � N no vetor de sa�da.
        somaX = X(n)*exp(-1*1j*(2*pi/N)*(k-1)*(n-1))+ somaX;
    end
    Y(k)= somaX; %Preenche o valor correspondente � N do sinal transformado.
end
end