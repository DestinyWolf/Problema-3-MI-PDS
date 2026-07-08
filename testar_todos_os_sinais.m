sinais = {"motor_saudavel.mat", "motor_desbalanceado.mat", "sinal_degrau.mat", "falha_rolamento.mat", "sinal_chirp.mat"};
arquivos = {"motor_saudavel", "motor_desbalanceado", "sinal_degrau", "falha_rolamento", "sinal_chirp"};

for idx =1:length(sinais)

    [ sucesso,kb_armazenado] = comprimir_sinal("sinais_originais/"+sinais(idx), arquivos(idx));
    
    sinal_reconstuido = descomprimir_sinal(arquivos(idx));
    
    variaveis = who('-file', "sinais_originais\"+sinais(idx));
    sinal_original = load("sinais_originais\"+sinais(idx)).(""+variaveis(variaveis ~= "fs"));
    sinal_original = sinal_original(:).';
    sinal_original_ajustado = [sinal_original zeros(1, (length(sinal_reconstuido)-length(sinal_original)))];
    sinal_original_ajustado = round(32767 * (sinal_original_ajustado/max(abs(sinal_original_ajustado)))); %correção so sinal original para 16 bits
    dct_original = tcd3_manual(sinal_original_ajustado);
    dct_reconstruido = tcd3_manual(sinal_reconstuido);

    [snr_db, cr, erro_harmonicas, erro_bandas] = calcular_metricas(sinal_original_ajustado, sinal_reconstuido, ...
        kb_armazenado, 1000, dct_original, dct_reconstruido);

    fprintf("RESULTADOS DO SINAL: %s \n", ""+sinais(idx));
    fprintf("SNR: %.2f\n", snr_db);
    fprintf("Taxa de Compressão: %.2f:1\n", cr);
    fprintf("Erro nas harmônicas: ");
    disp(erro_harmonicas);
    fprintf("Erro Bandas laterais: ");
    disp(erro_bandas);
    

    figure('Name', "Comparação da reconstrução para o sinal: "+sinais(idx));
    plot([1:300], sinal_original_ajustado(1:300), 'b-', [1:300], sinal_reconstuido(1:300), 'r--', 'LineWidth', 1.5);
    grid on;
    title("Comparação do sinal reconstruido com o sinal original")
    xlabel("Amostra")
    ylabel("Amplitude")
    legend(["Sinal Original" "Sinal Reconstruido"]);
end