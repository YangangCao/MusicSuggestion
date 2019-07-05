% test unit

tmp_path = "/Users/baboo/Desktop/tmp/mfm/Ana Alcaide - Tishri.mp3";

[au, fs] = audioread(tmp_path);

[energy_vec, energy_vec_sort] = au2energy(au);