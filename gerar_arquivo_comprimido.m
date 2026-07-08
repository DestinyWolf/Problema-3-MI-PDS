
%% Função responsavel por serializar uma matriz de dados quantizados e armazenar no disco
function size_on_kb = gerar_arquivo_comprimido(blocos_quantizados, delta, tam_bloco, nome_arquivo)

    % serializando a matriz em um vetor linha
    vetor = blocos_quantizados(:);

    %% Codificação ZRLE

    %encontrar os valores não nulos e a quantidade de zeros antes deles
    idx_nz = find(vetor ~= 0);
    valores_nz = vetor(idx_nz);
    run_zeros = diff([0; idx_nz]) - 1;

    %% Criação do arquivo

    % Cria um arquivo no modo escrita
    f = fopen(nome_arquivo+".cmc", 'w');
    if f == -1
        error("Não foi possivel criar o arquivo binario, por favor verifique o nome ou se voce tem permissões para esta opereação!")
    end
    tam_vetor = length(vetor);
    num_pares_nz = length(valores_nz);
    
    %% Escrita do cabeçalho (16 bytes)
    fwrite(f, delta, 'uint16');
    fwrite(f, tam_bloco, 'uint16');
    fwrite(f, tam_vetor, 'uint32');
    fwrite(f, num_pares_nz, 'uint32');

    %% escrita dos dados da ZRLE
    for idx=1:1:num_pares_nz
        fwrite(f, run_zeros(idx), 'uint16');
        fwrite(f, valores_nz(idx), 'int16');
    end

    fclose(f);

    info = dir(nome_arquivo+".cmc");
    size_on_kb = (info.bytes/1024);
    fprintf("\n -> arquivo gerado: %s salvo!\n", nome_arquivo+".cmc")

end