clear;
close all;

num_img_training = 10;
target_size = [1064, 1064, 3];
immagini_tr = zeros([target_size, num_img_training], 'uint8');
immagini_gt = false([target_size(1:2), num_img_training]);

immagini_tr(:,:,:,1) = imresize(imread("Training/oleandro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,2) = imresize(imread("Training/salvia_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,3) = imresize(imread("Training/ulivo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,4) = imresize(imread("Training/rosmarino_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,5) = imresize(imread("Training/prezzemolo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,6) = imresize(imread("Training/edera_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,7) = imresize(imread("Training/alloro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,8) = imresize(imread("Training/quercia_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,9) = imresize(imread("Training/lauroceraso_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,10) = imresize(imread("Training/lauroceraso_training.jpg"), target_size(1:2));

immagini_gt(:,:,1) = imresize(im2gray(imread("Gt/Train/gt_oleandro_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,2) = imresize(im2gray(imread("Gt/Train/gt_salvia_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,3) = imresize(im2gray(imread("Gt/Train/gt_ulivo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,4) = imresize(im2gray(imread("Gt/Train/gt_rosmarino_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,5) = imresize(im2gray(imread("Gt/Train/gt_prezzemolo_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,6) = imresize(im2gray(imread("Gt/Train/gt_edera_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,7) = imresize(im2gray(imread("Gt/Train/gt_alloro_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,8) = imresize(im2gray(imread("Gt/Train/gt_quercia_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,9) = imresize(im2gray(imread("Gt/Train/gt_lauroceraso_training.png")) > 0, target_size(1:2));
immagini_gt(:,:,10) = imresize(im2gray(imread("Gt/Train/gt_trifoglio_training.png")) > 0, target_size(1:2));

save("im_training.mat", "immagini_gt", "immagini_tr", "num_img_training", "target_size");



