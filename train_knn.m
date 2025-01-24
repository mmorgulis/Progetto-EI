% Per fare knn leggo tutte le ground_truth
% in cui 0 = sfondo e 1 = foglia e alleno knn
clear;
close all;

num_img_training = 3;
immagini_tr = cell(1, num_img_training); % array di celle 1x3
immagini_tr{1} = imread("oleandro_training.jpg");
immagini_tr{2} = imread("salvia_training.jpg");
immagini_tr{3} = imread("ulivo_training.jpg");

immagini_gt = cell(1, num_img_training);
immagini_gt{1} = imread();
immagini_gt{2} = imread();
immagini_gt{3} = imread();

var_loc = [];
col_loc = [];

for i = 1:num_img_training
    im = immagini_tr{i};
    var = compute_local_var(im, 31);
    col = compute_local_col(im, 31);

    var_loc = [var_loc; var];
    col_loc = [col_loc; col];
end