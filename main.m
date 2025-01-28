clear;
close all;

im = imread("2.jpg");
leafs = localize_leaf(im);
figure, imshow(leafs);
