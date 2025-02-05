clear;
close all;

im = imread("Test\prezzemolo_test.jpg");
im = imresize(im, 0.25);
leaf = localize_leaf(im);
%figure, imshow(leaf);

labels = bwlabel(leaf);
area = regionprops(labels, 'Area');
filter = find([area.Area] >= 100);
labels_filtered = ismember(labels, filter);
labels_final = bwlabel(labels_filtered);
num_comp_conn = max(max(labels_final));
%figure, imagesc(labels_final), axis image, colorbar;


for i = 1:num_comp_conn
    foglia_bin = labels_final == i;
    foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
    foglia_rgb = im .* uint8(foglia_bin_3d);
    %figure, imshow(foglia_rgb);
    compute_shape(foglia_rgb);
    % im ha la scritta con la classe di appartenenza
    
end
%figure, imshow(im_class);

