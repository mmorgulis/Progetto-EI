clear;
close all;

im = imread("Training\oleandro_training.jpg");
leaf = localize_leaf(im);
figure, imshow(leaf);
labels = bwlabel(leaf);
num_comp_conn = max(max(labels));
for i = 1:num_comp_conn

end
figure, imagesc(labels), axis image, colorbar;


%[mag, phase] = imgaborfilt(im2gray(im), 4, 90);
%im_hsv = rgb2hsv(im);
%im_yc = rgb2ycbcr(im);
%sat = im_hsv(:, :, 2);
%y = im_yc(:, :, 1);
%cedd = compute_CEDD(im);
%lbp = compute_lbp(im);
%leafs = localize_leaf(im);

%figure, imshow(y);
%figure, imshow(mag, []);
%figure, imshow(sat);
%figure, imshow(compute_lbp(im));
