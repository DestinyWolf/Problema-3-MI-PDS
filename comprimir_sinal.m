%% Funçao responsavel por comprimir o sinal e o armazenar em um arquivo binario com extensão .cmc 
% No nome do arquivo a ser salvo não precisa adicionar a extensão .cmc
function [sucesso, tamanho_arquivo] = comprimir_sinal(nome_do_sinal,nome_do_arquivo)

    if nargin < 2
        nome_do_arquivo = nome_do_sinal+"-comprimido";
    end
    sucesso = 0;
    tam_bloco = 4096;
    delta = 256;
    limiar = 2048;
    variaveis = who('-file', nome_do_sinal);
    nome_variavel = variaveis(1);

    for idx=1:length(variaveis)
        if variaveis(idx) ~= "fs" && variaveis(idx) ~= "Fs" && variaveis(idx) ~= "FS"
            nome_variavel = variaveis(idx);
            break;
        end

    end
 
    sinal = load(nome_do_sinal).(""+nome_variavel);

    sinal = sinal(:).';
    
    sinal_convertido_para_16_bits = round(32767 * (sinal/max(abs(sinal))));


    blocos_quantizados = codificador(sinal_convertido_para_16_bits, tam_bloco, limiar, delta);

    tamanho_arquivo = gerar_arquivo_comprimido(blocos_quantizados, delta, tam_bloco, nome_do_arquivo);

    sucesso = 1;
end