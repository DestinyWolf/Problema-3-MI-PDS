% ======================================================
% Arquivo: tcd3_manual.m
% Autor: Camila Boa Morte e Maike de Oliveira
% Descrição: Esta função implementa o cálculo da
% TCD-III ortonormalizada com base na definição analítica
%
% Parametros de entrada:
% x: amostras do sinal de entrada
%
% Parametros de saida:
% X: coeficientes da Transformada Cosseno Discreta III
% ======================================================


function X = tcd3_manual(x)
  x = x(:).';       % Formatação do sinal de entrada para um vetor linha
  N = length(x);    % Comprimento do sinal de entrada

  % =====================================
  % Cálculo da TCD-III por definição
  % =====================================

  X = zeros(1,N);   % Inicialização do vetor de saída

  n = 1:(N-1);      % Vetor de índices n

  for k=0 : N-1
    somatorio = sum(x(n+1) .* cos((pi/N) * (k + 0.5) * n));
    X(k+1) = (sqrt(1/N) * x(1)) + (sqrt(2/N) * somatorio);

  end

end
