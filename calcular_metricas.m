% =========================================================================
% CÁLCULO DE MÉTRICAS (Avaliação de Desempenho)
% =========================================================================
function [snr_db, cr, erro_harmonicas, erro_bandas] = calcular_metricas(sinal_original, sinal_reconstruido, bits_comprimidos, fs, X_orig, X_recons)
    % 1. SNR
    erro = sinal_original - sinal_reconstruido;
    potencia_sinal = sum(sinal_original.^2);
    potencia_erro = sum(erro.^2);

    if potencia_erro == 0
        snr_db = Inf;
    else
        snr_db = 10 * log10(potencia_sinal / potencia_erro);
    end

    % 2. CR (Taxa de Compressão)
    bits_originais = (length(sinal_original) * 8) / 1024;
    cr = bits_originais / bits_comprimidos;

    % 3. Erro nas harmônicas principais
    N = length(sinal_original);
    harmonicas = [30, 60, 90, 120, 150];
    num_harmonicas = length(harmonicas);
    indices = round((harmonicas*2*N)/fs);

    erro_harmonicas = zeros(1, num_harmonicas);
    for k=1:num_harmonicas
      idx = indices(k);
      erro_harmonicas(k) = abs(X_orig(idx) - X_recons(idx))/abs(X_orig(idx));
      erro_harmonicas(k) = erro_harmonicas(k)*100;
    end

    % 4. Erro das bandas laterais
    bandas_laterais = [20 25 35 40 91.5 148.5];
    num_bandas = length(bandas_laterais);
    indices_bandas = round((bandas_laterais*2*N)/fs);

    erro_bandas = zeros(1, num_bandas);
    for k=1:num_bandas
      idx = indices_bandas(k);
      erro_bandas(k) = abs(X_orig(idx) - X_recons(idx))/abs(X_orig(idx));
      erro_bandas(k) = erro_bandas(k) * 100;
    end



end
