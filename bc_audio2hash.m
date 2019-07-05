% audio2hash function

function hash = bc_audio2hash(audio, fs, hp_control)

% resample audio data
% VIP: audio must be mono
FS = 8000;
audio = resample(audio, FS, fs);

% get spectrum
FRAME_SIZE = 1024;
OVERLAP_RATIO = 0.5;

window = blackman(FRAME_SIZE);
spect = spectrogram(audio, window, FRAME_SIZE*OVERLAP_RATIO);
spect = abs(spect);
spectMax = max(spect(:));
spect = max(spect, spectMax/300); % filter out -60dB component
spect = 20*log10(spect);
spect = spect - mean(spect(:));


% apply filter to spectrum
if hp_control
    B = [1, -1];
    A = [1, -0.98];
    spect = filter(B, A, spect');
    spect = spect';
end

% get maximum points
DILATE_SIZE = 30;
SE = strel('square', DILATE_SIZE);
spect_dilate = imdilate(spect, SE);
max_thresh = max(max(spect))*0.1;
[ROW, COL] = find(spect == spect_dilate & spect>max_thresh);
max_position = [ROW, COL];

% sort maximum points based on time
tmaxes = sortrows(max_position,2);

% constants control
DEL_TIME = 80;
DEL_FREQ = 60; % bilateral

fingerprint = [0, 0];
% build up fingerprints
len_max = length(tmaxes);
for i = 1:len_max
    tmp_finger = [0, 0];
    for j = 1:100 % check onehundred points
        if i+j <= len_max
            freq1 = tmaxes(i, 1);
            freq2 = tmaxes(i+j, 1);
            freq_del = freq2 - freq1;
            t1 = tmaxes(i, 2);
            t2 = tmaxes(i+j, 2);
            t_del = t2 - t1;
            
            if t_del < DEL_TIME && abs(freq_del)<DEL_FREQ
                id = freq1*10^6 + freq2*10^3 + t_del;
                tmp_finger = [tmp_finger; [id, t1]];
            end
        end
    end
    fingerprint = [fingerprint; tmp_finger(2:end,:)];
end
fingerprint = fingerprint(2:end,:);

hash = fingerprint;

DEBUG = 0;
if DEBUG
    %disp(length(hash));
    pcolor(spect);
    shading interp;
    hold on
    plot(max_position(:,2), max_position(:,1), 'Ok','LineWidth', 2);
    disp("Finished!");
end
end