clear;
close all;

num_img_training = 10;
target_size = [1064, 1064, 3]; % 1/8 foto originale
immagini_test = zeros([target_size, num_img_training], 'uint8');
immagini_gt_test = false([target_size(1:2), num_img_training]);

immagini_test(:,:,:,1) = imresize(imread("Test/oleandro_test.jpg"), target_size(1:2));
immagini_test(:,:,:,2) = imresize(imread("Test/ciclamino_test.jpg"), target_size(1:2));
immagini_test(:,:,:,3) = imresize(imread("Test/ulivo_test.jpg"), target_size(1:2));
immagini_test(:,:,:,4) = imresize(imread("Test/rosmarino_test.jpg"), target_size(1:2));
immagini_test(:,:,:,5) = imresize(imread("Test/prezzemolo_test.jpg"), target_size(1:2));
immagini_test(:,:,:,6) = imresize(imread("Test/edera_test.jpg"), target_size(1:2));
immagini_test(:,:,:,7) = imresize(imread("Test/alloro_test.jpg"), target_size(1:2));
immagini_test(:,:,:,8) = imresize(imread("Test/quercia_test.jpg"), target_size(1:2));
immagini_test(:,:,:,9) = imresize(imread("Test/lauroceraso_test.jpg"), target_size(1:2));
immagini_test(:,:,:,10) = imresize(imread("Test/trifoglio_test.jpg"), target_size(1:2));

immagini_gt_test(:,:,1) = imresize(im2gray(imread("Gt/Test/gt_oleandro_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,2) = imresize(im2gray(imread("Gt/Test/gt_ciclamino_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,3) = imresize(im2gray(imread("Gt/Test/gt_ulivo_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,4) = imresize(im2gray(imread("Gt/Test/gt_rosmarino_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,5) = imresize(im2gray(imread("Gt/Test/gt_prezzemolo_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,6) = imresize(im2gray(imread("Gt/Test/gt_edera_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,7) = imresize(im2gray(imread("Gt/Test/gt_alloro_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,8) = imresize(im2gray(imread("Gt/Test/gt_quercia_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,9) = imresize(im2gray(imread("Gt/Test/gt_lauroceraso_test.png")) > 0, target_size(1:2));
immagini_gt_test(:,:,10) = imresize(im2gray(imread("Gt/Test/gt_trifoglio_test.png")) > 0, target_size(1:2));

save("im_test.mat", "immagini_gt_test", "immagini_test", "num_img_training", "target_size");
