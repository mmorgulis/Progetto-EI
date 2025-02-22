clear;
close all;

% Immagini con sfondi differenti per irrobustire locator
num_img_oth = 5; 
target_size = [1064, 1064, 3];
immagini_sf = zeros([target_size, num_img_oth], 'uint8');
immagini_gt_oth = false([target_size(1:2), num_img_oth]);

% Sfondo legno
immagini_sf(:,:,:,1) = imresize(imread("Training/Legno/ciclamino_training.png"), target_size(1:2));

% Sfondo rosso
immagini_sf(:,:,:,2) = imresize(imread("Training/Rosso/ulivo_trainingR.jpg"), target_size(1:2));

% Sfondo verde
immagini_sf(:,:,:,3) = imresize(imread("Training/Verde/quercia_trainingG.jpg"), target_size(1:2));

% Sfondo blu
immagini_sf(:,:,:,4) = imresize(imread("Training/Blu/prezzemolo_trainingB.jpg"), target_size(1:2));

% Altri sfondi
immagini_sf(:,:,:,5) = imresize(imread("Training/Altro/alloro_training.png"), target_size(1:2));

% Ground truth 
immagini_gt_oth(:,:,1) = imresize(im2gray(imread("Gt/Train/gt_ciclamino_training.png")) > 0, target_size(1:2));
immagini_gt_oth(:,:,2) = imresize(im2gray(imread("Gt/Train/gt_ulivo_training.png")) > 0, target_size(1:2));
immagini_gt_oth(:,:,3) = imresize(im2gray(imread("Gt/Train/gt_quercia_training.png")) > 0, target_size(1:2));
immagini_gt_oth(:,:,4) = imresize(im2gray(imread("Gt/Train/gt_prezzemolo_training.png")) > 0, target_size(1:2));
immagini_gt_oth(:,:,5) = imresize(im2gray(imread("Gt/Train/gt_alloro_training.png")) > 0, target_size(1:2));

save("im_training_oth.mat", "immagini_sf", "immagini_gt_oth", "num_img_oth");