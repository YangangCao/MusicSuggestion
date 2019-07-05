% au2energy

function [energy_vec, energy_vec_sort] = au2energy(au)
au_mono = (au(:, 1) + au(:, 2))/2;

numSample = length(au_mono);

numBlock = 100;

lenBlock = floor(numSample/numBlock);

energy_vec = zeros(numBlock, 1);

for i = 1: numBlock
    blocktmp = au_mono((i-1)*lenBlock+1 : i*lenBlock, 1);
    energy_vec(i,1) = rms(blocktmp);
end

energy_vec_cp = energy_vec;

energy_vec = energy_vec/norm(energy_vec);

energy_vec_sort = sort(energy_vec_cp);

energy_vec_sort = resample(energy_vec_sort, 10, 100);

end