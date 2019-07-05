% main au2vec

% % test
clc;
clear;

tic;

folder_path = "/Volumes/Seagate Exp/test/";
target_path = "/Volumes/Seagate Exp/test_vec/";

%folder_path = "d:\mp3\";
%target_path = "d:\mp3_vec\";

file_list = dir(folder_path);
numFile = length(file_list);

parfor i = 1: numFile
    %disp(i);
    [~, name, ext] = fileparts(file_list(i).name);
    if (strcmp(ext,'.mp3') || strcmp(ext,'.wav') || strcmp(ext,'.m4a'))
         tmp_path = strcat(folder_path, name, ext);
         writing_path = strcat(target_path, name, '.csv');
         %disp(tmp_path);
         %disp(writing_path);
         try
             VEC = au2vec(tmp_path);
             %disp(VEC);
             if VEC(1) ~= 0
                 dlmwrite(writing_path, VEC, 'precision', 32, 'delimiter', ',');
                 disp(strcat('Finish file: ', writing_path));
             end
         catch
             disp(strcat('Error for file: ', tmp_path));
         end
    end
end
disp(strcat("Process is Finished for: ", folder_path));
toc;

disp('All Finished!')
