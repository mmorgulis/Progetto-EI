clear;
close all;

num_img_training = 5;
target_size = [1064, 1064, 3]; 
immagini_tr = zeros([target_size, num_img_training], 'uint8');

[labels] = read();
immagini_tr(:,:,:,1) = imresize(imread("Training/oleandro_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,2) = imresize(imread("Training/salvia_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,3) = imresize(imread("Training/ulivo_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,4) = imresize(imread("Training/rosmarino_training.jpg"), target_size(1:2));
immagini_tr(:,:,:,5) = imresize(imread("Training/prezzemolo_training.jpg"), target_size(1:2));
