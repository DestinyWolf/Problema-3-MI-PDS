%% Função para calcular a Inversa da DCT-III (IDCT-III) manualmente
function x = itcd3_manual(X)
  X = X(:).';       % Formatando o vetor de coeficientes para um vetor linha
  N = length(X);    % Comprimento do sinal de entrada

  x = zeros(1,N);   % Inicialização do vetor de saída

  n = 0:(N-1);      % Vetor de índices n para o somatório

    for k = 0 : N-1
        somatorio_interno = sum(X .* cos((pi/N) * k * (n + 0.5)));
    
        if k == 0
          fator_normalizacao = sqrt(1/N);
        else
          fator_normalizacao = sqrt(2/N);
        end

    x(k+1) = fator_normalizacao * somatorio_interno;  % Normalização do somatório
    end
end
