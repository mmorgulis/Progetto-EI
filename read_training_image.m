clear;
close all;

num_img_training = 10; 
target_size = [1064, 1064, 3];
immagini_tr = zeros([target_size, num_img_training], 'uint8');
immagini_gt = false([target_size(1:2), num_img_training]);

% Sfondo bianco
immagini_tr(:,:,:,1) = imresize(imread("Training/Bianco/oleandro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,2) = imresize(imread("Training/Bianco/ciclamino_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,3) = imresize(imread("Training/Bianco/ulivo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,4) = imresize(imread("Training/Bianco/rosmarino_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,5) = imresize(imread("Training/Bianco/prezzemolo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,6) = imresize(imread("Training/Bianco/edera_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,7) = imresize(imread("Training/Bianco/alloro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,8) = imresize(imread("Training/Bianco/quercia_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,9) = imresize(imread("Training/Bianco/lauroceraso_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,10) = imresize(imread("Training/Bianco/trifoglio_training.jpg"), target_size(1:2));

% Ground truth 
immagini_gt(:,:,1) = imresize(im2gray(imread("Gt/Train/gt_oleandro_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,2) = imresize(im2gray(imread("Gt/Train/gt_ciclamino_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,3) = imresize(im2gray(imread("Gt/Train/gt_ulivo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,4) = imresize(im2gray(imread("Gt/Train/gt_rosmarino_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,5) = imresize(im2gray(imread("Gt/Train/gt_prezzemolo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,6) = imresize(im2gray(imread("Gt/Train/gt_edera_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,7) = imresize(im2gray(imread("Gt/Train/gt_alloro_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,8) = imresize(im2gray(imread("Gt/Train/gt_quercia_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,9) = imresize(im2gray(imread("Gt/Train/gt_lauroceraso_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,10) = imresize(im2gray(imread("Gt/Train/gt_trifoglio_training.png")) > 0, target_size(1:2));

save("im_training.mat", "immagini_gt", "immagini_tr", "num_img_training", "target_size");