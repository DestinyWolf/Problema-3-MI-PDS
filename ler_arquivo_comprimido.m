%% Função responsavel por realizar a leitura de um arquivo comprimido e devolver as informações armazenadas nele
function [blocos_quantizados, delta, N_bloco] = ler_arquivo_comprimido(nome_arquivo)
    f = fopen(nome_arquivo+".cmc", "r");

    if f == -1
        error("Não foi possivel encontrar o arquivo comprimido, verifique a ortografia do nome e tente novamente (digitar sem a extensão)");
    end

    %% Realizar a leitura do cabeçalho
    delta = fread(f, 1, 'uint16');
    N_bloco = fread(f, 1, 'uint16');

    tam_vetor_original = fread(f, 1, 'uint32');
    num_pares_nz = fread(f, 1, 'uint32');

    %% cria um vetor para o payload
    vetor_original = zeros(tam_vetor_original, 1);
    idx_atual = 1;

    for i =1:1:num_pares_nz
        num_z = fread(f, 1, 'uint16');
        valor_nz = fread(f, 1, 'int16');

        idx_atual = idx_atual + double(num_z);
        vetor_original(idx_atual) = double(valor_nz);
        idx_atual = idx_atual + 1;
    end

    %% Realiza o fechamento do arquivo
    fclose(f);

    %% Recriação da matriz serializada


    num_blocos = length(vetor_original)/N_bloco;
    blocos_quantizados = reshape(vetor_original, N_bloco, num_blocos);

    fprintf("-> Arquivo lido: %s\n", nome_arquivo+".cmc");

end