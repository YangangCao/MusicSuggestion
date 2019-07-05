function vec = au2vec(audio_path)
[au, fs] = audioread(audio_path);

[numSample, numChannel] = size(au);

LENGTH = numSample/fs;

if numChannel == 1
    error("the audio must be stereo");
end

% get energy [1]
RMS = mean(rms(au));
% get width [1]
WIDTH = au2width(au);

% bpm and freq_vec [90, 1]
[FREQ_VEC, BPM] = au2cqtvec(au, fs);

% energy distribution[100, 10]
[ENG_VEC_NORM, ENG_VEC_SORT] = au2energy(au);

% FREQ -> 90 CQT engergy distribution
% ENG_VEC_NORM -> 100 mesure distribution
% ENG_VEC_SORT -> 10 sorted distribution
vec = [LENGTH; RMS; WIDTH; BPM; FREQ_VEC; ENG_VEC_NORM; ENG_VEC_SORT];
end