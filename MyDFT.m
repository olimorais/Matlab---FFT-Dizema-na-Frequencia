function [Y,ws] = MyDFT(X,fs)

N = length(X);            %N é correspondente ao número de pontos do vetor de entrada.
NP = ceil(log2(N));  %O comando ceil retorna a potência de 2 mais próxima do
%valor de entrada atual. Por exemplo, um sinal de 2000 pontos, a próxima
%potência de 2 seria 2048 o que daria 2^11 e então NP seria 11.

if (2^NP ~= N)
    X = [X zeros(1,(2^NP)- N)];  % Preenchimento com zeros até chegar a 2^NP.
end

N = length(X);    %Agora o sinal já é uma potência de 2 e poderá ser utilizado
%o mecanismo de dizimação no tempo.

ws = 0:fs/N:fs-(fs/N);    

%Implementação da DFT via fórmula:

for k=1:1:N      %Percorre os N valores do vetor de entrada para preencher as N posições do vetor de saída. 
    somaX = 0;
    for n=1:1:N  %Percorre os N valores do vetor de entrada para fazer as N multiplicações pela exponencial
                 %e assim obter o valor correspondente à N no vetor de saída.
        somaX = X(n)*exp(-1*1j*(2*pi/N)*(k-1)*(n-1))+ somaX;
    end
    Y(k)= somaX; %Preenche o valor correspondente à N do sinal transformado.
end
end