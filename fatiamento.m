%% Função responsável por fazer o fatiamento do sinal em blocos de tamanho N (Faz o padding com zero quando necessario)
function [vetores, num_blocos] = fatiamento(sinal, tamanho_bloco)
    if size(sinal, 1) ~= 1
        sinal = sinal(:).';
    end
    
    num_cols=tamanho_bloco;
    N = length(sinal);

    if mod(N, tamanho_bloco) ~= 0
        tamanho_final = max(tamanho_bloco*ceil(N/tamanho_bloco), tamanho_bloco);
        sinal_tratado = [sinal, zeros(1, abs(tamanho_final-N))];
    elseif N < tamanho_bloco
        tamanho_final = tamanho_bloco;
        sinal_tratado = [sinal, zeros(1, abs(tamanho_bloco-N))];
    else 
        tamanho_final = N;
    end
    num_blocos=ceil(tamanho_final/tamanho_bloco);
    vetores = zeros(num_blocos,num_cols);
    for i=1:ceil(tamanho_final/tamanho_bloco)
        vetores(i,:) = sinal_tratado((tamanho_bloco*(i-1))+1:(tamanho_bloco*i));
    end
end 