function width = au2width(au)
% rms ratio between side and mono

au_mono = (au(:, 1) + au(:, 2))/2;
au_side = au(:, 1) - au_mono;

% 2 parameters relate to RMS
rms_mono = rms(au_mono);
rms_side = rms(au_side);

% get ratio
width = rms_side/rms_mono;
end


