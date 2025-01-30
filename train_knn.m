% Per fare knn leggo tutte le ground_truth
% in cui 0 = sfondo e 1 = foglia e alleno knn
clear;
close all;

num_img_training = 4;
target_size = [1064, 1064];
finestra = 3; % scelta empiricamente
immagini_tr = cell(1, num_img_training); % array di celle 
immagini_tr{1} = imread("Training\oleandro_training.jpg");
immagini_tr{2} = imread("Training\salvia_training.jpg");
immagini_tr{3} = imread("Training\ulivo_training.jpg");
immagini_tr{4} = imread("Training\rosmarino_training.jpg");

immagini_gt = cell(1, num_img_training);
immagini_gt{1} = im2gray(imread("Gt\Train\gt_oleandro_training.png")) > 0;
immagini_gt{2} = im2gray(imread("Gt\Train\gt_salvia_training.png")) > 0;
immagini_gt{3} = im2gray(imread("Gt\Train\gt_ulivo_training.png")) > 0;
immagini_gt{4} = im2gray(imread("Gt\Train\gt_rosmarino_training.png")) > 0;

immagini_test = cell(1, num_img_training);
immagini_test{1} = imread("Test\oleandro_test.jpg");
immagini_test{2} = imread("Test\salvia_test.jpg");
immagini_test{3} = imread("Test\ulivo_test.jpg");
immagini_test{4} = imread("Test\rosmarino_test.jpg");

immagini_gt_test = cell(1, num_img_training);
immagini_gt_test{1} = im2gray(imread("Gt\Test\gt_oleandro_test.png")) > 0;
immagini_gt_test{2} = im2gray(imread("Gt\Test\gt_salvia_test.png")) > 0;
immagini_gt_test{3} = im2gray(imread("Gt\Test\gt_ulivo_test.png")) > 0;
immagini_gt_test{4} = im2gray(imread("Gt\Test\gt_rosmarino_test.png")) > 0;

for i = 1:num_img_training
    immagini_tr{i} = imresize(immagini_tr{i}, target_size);
    immagini_gt{i} = imresize(immagini_gt{i}, target_size);
    immagini_test{i} = imresize(immagini_test{i}, target_size);
    immagini_gt_test{i} = imresize(immagini_gt_test{i}, target_size);
end

% Prealloco, devono avere la stessa forma
all_features = [];
%zeros(4528384, 5);
all_labels = [];

for i = 1:num_img_training
    im = immagini_tr{i};
    gt = immagini_gt{i};
    
    features = compute_all_features(im, finestra);
    [r, c, num_features] = size(features);
    features_reshaped = reshape(features, r * c, num_features);

    labels_reshaped = gt(:); 

    all_features = [all_features; features_reshaped];
    all_labels = [all_labels; labels_reshaped];
end

X = all_features;
Y = all_labels;

% Creo il modello kNN
C = fitcknn(X, Y, 'NumNeighbors', 7);

% Calcolo le performance sul test-set
test_all_features = [];
for i = 1:num_img_training
    test_features = compute_all_features(immagini_test{i}, finestra);
    [tr, tc, t_num_features] = size(test_features);
    test_features_reshaped = reshape(test_features, tr * tc, t_num_features);

    test_all_features = [test_all_features; test_features_reshaped];

    test_X = test_all_features;
    
    pred_labels = predict(C, test_X);
    
    pred_image = reshape(pred_labels, target_size);
    
    gt_logical = logical(immagini_gt_test{i});
    pred_logical = logical(pred_image);
    
    % Visualizzo i risultati
    figure;
    subplot(1, 3, 1);
    imshow(immagini_test{i});
    title('Immagine di Test');
    
    subplot(1, 3, 2);
    imshow(pred_image, []);
    title('Predizione kNN');
    
    subplot(1, 3, 3);
    imshow(immagini_gt_test{i});
    title(['Ground Truth']);
    
    % Uso ConfMat
    cm_test = confmat(gt_logical, pred_logical);
    figure;
    show_confmat(cm_test.cm_raw, cm_test.labels);
    title("Test");

    fprintf('Test Accuracy: %f\n', cm_test.accuracy);

    save("data.mat", "C");

end