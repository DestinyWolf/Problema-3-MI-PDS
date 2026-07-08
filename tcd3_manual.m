%% Função para calcular a Transformada Discreta do Cosseno (DCT) de um sinal de entrada

function X = tcd3_manual(x)
  x = x(:).';       % Formatação do sinal de entrada para um vetor linha
  N = length(x);    % Comprimento do sinal de entrada

  X = zeros(1,N);   % Inicialização do vetor de saída

  n = 1:(N-1);      % Vetor de índices n

  for k=0 : N-1
    somatorio_interno = sum(x(n+1) .* cos((pi/N) * (k + 0.5) * n));
    X(k+1) = (sqrt(1/N) * x(1)) + (sqrt(2/N) * somatorio_interno);  % Normalização do somatorio

  end

end
