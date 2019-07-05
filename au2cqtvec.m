% au2cqt vec

function [freq_vec, bpm] = au2cqtvec(au, fs)

au = au(:, 1) + au(:, 2);

au = resample(au, 8000, fs);

cqt_graph = abs(cqt(au,'SamplingFrequency',8000));

key_graph = cqt_graph(156:245, :);
freq_stat = sum(key_graph, 2);
freq_vec = freq_stat/norm(freq_stat);
% finish frequency part

dsf = 50;
fsd = fs/dsf;
energy_stat = sum(key_graph, 1);
energy_stat = energy_stat - mean(energy_stat);
energy_stat = HP(energy_stat, fs, 300);
energy_stat = resample(energy_stat, fsd, fs);
energy_freq = abs(fft(energy_stat));
pos = find(energy_freq == max(energy_freq));
bpm = (pos(1)-1)/fsd*60;

% put the condition to right position
while bpm >= 140 || bpm <= 70
    if bpm >=140
        bpm = bpm/2;
    end
    if bpm <=140
        bpm = bpm*2;
    end
end

end