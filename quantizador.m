%% Função responsavel por realizar a quantização com zona morta
function [bloco_quantizado] = quantizador(bloco, limiar, delta)
    bloco(abs(bloco)<limiar) = 0; % Força o valor zero em amostras com valor absoluto menor que o limiar

    bloco_quantizado = round(bloco/delta); %divide pelo passo de quantização e arredonda para o bit mais próximo
end