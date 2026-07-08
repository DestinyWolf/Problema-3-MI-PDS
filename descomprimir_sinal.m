%% Função responsavel pela descompressão do sinal
function [sinal_reconstruido] = descomprimir_sinal(nome_do_arquivo)
    [blocos_lidos, delta, tam_blocos] = ler_arquivo_comprimido(nome_do_arquivo);

    sinal_reconstruido = decodificador(blocos_lidos, tam_blocos, delta);
end