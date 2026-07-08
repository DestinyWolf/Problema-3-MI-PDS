function x = itcd3_manual(X)
  X = X(:).';       % Formatando o vetor de coeficientes para um vetor linha
  N = length(X);    % Comprimento do sinal de entrada

  % =====================================
  % Cálculo da Inversa da DCT-III
  % =====================================

  x = zeros(1,N);   % Inicialização do vetor de saída

  n = 0:(N-1);      % Vetor de índices n para o somatório

    for k = 0 : N-1
        somatorio = sum(X .* cos((pi/N) * k * (n + 0.5)));
    
        if k == 0
          ck = sqrt(1/N);
        else
          ck = sqrt(2/N);
        end

    x(k+1) = ck * somatorio;
    end
end
