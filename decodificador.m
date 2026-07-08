%% Função responsavel por fazer reconstrução do sinal original a partir dos blocos quantizados
function [sinal_reconstruido] = decodificador(blocos_quantizados, tam_bloco, delta)
    num_blocos = size(blocos_quantizados, 2);
    sinal_reconstruido = zeros(1, num_blocos*tam_bloco);

    for idx=1:1:num_blocos
       tmp_bloco = blocos_quantizados(:, idx);
       bloco_desquantizado = tmp_bloco*delta;
       bloco_reconstruido = itcd3_manual(bloco_desquantizado);

       indice_inicio = ((idx-1)*tam_bloco)+1;
       indice_fim = idx*tam_bloco;
       sinal_reconstruido(indice_inicio:indice_fim) = bloco_reconstruido;
    end
end