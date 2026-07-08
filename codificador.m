%% Função responsavel por agrupar as funções necessarias para a compressão de um sinal
function [blocos_quantizados] = codificador(sinal, tam_bloco, limiar, delta)
    
    [sinal_fatiado,num_blocos] = fatiamento(sinal, tam_bloco);
    
    blocos_quantizados = zeros(tam_bloco, num_blocos);

    for idx=1:1:num_blocos
        tcd_bloco = tcd3_manual(sinal_fatiado(idx,:)');
        blocos_quantizados(:,idx) = quantizador(tcd_bloco, limiar, delta)';
    end

end