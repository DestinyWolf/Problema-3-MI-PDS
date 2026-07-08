
%% Função responsavel pela desquantização do sinal
function [bloco_desquantizado] = desquantizador(bloco_quantizado, delta)
    
    bloco_desquantizado = bloco_quantizado*delta;
    
end