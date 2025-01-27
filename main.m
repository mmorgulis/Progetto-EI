clear;
close all;

%im = imread("salvia_training.jpg");
%img_bin = local_vector(im);
%figure, imshow(img_bin);
train_knn();

%gt = imread("gr_salvia_test.png") > 0;
%cm = confmat(gt, img_bin);
%figure(2), show_confmat(cm.cm_raw, {'noleaf','leaf'});