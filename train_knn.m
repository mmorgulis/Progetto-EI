% Per fare knn leggo tutte le ground_truth
% in cui 0 = sfondo e 1 = foglia e alleno knn
clear;
close all;

num_img_training = 3;
target_size = [1064, 1064];
finestra = 7; % scelta empiricamente
immagini_tr = cell(1, num_img_training); % array di celle 
immagini_tr{1} = imread("Training\oleandro_training.jpg");
immagini_tr{2} = imread("Training\salvia_training.jpg");
immagini_tr{3} = imread("Training\ulivo_training.jpg");

immagini_gt = cell(1, num_img_training);
immagini_gt{1} = im2gray(imread("Gt\Train\gt_oleandro_training.png")) > 0;
immagini_gt{2} = im2gray(imread("Gt\Train\gt_salvia_training.png")) > 0;
immagini_gt{3} = im2gray(imread("Gt\Train\gt_ulivo_training.png")) > 0;

immagini_test = cell(1, num_img_training);
immagini_test{1} = imread("Test\oleandro_test.jpg");
immagini_test{2} = imread("Test\salvia_test.jpg");
immagini_test{3} = imread("Test\ulivo_test.jpg");

immagini_gt_test = cell(1, num_img_training);
immagini_gt_test{1} = im2gray(imread("Gt\Test\gt_oleandro_test.png")) > 0;
immagini_gt_test{2} = im2gray(imread("Gt\Test\gt_salvia_test.png")) > 0;
immagini_gt_test{3} = im2gray(imread("Gt\Test\gt_ulivo_test.png")) > 0;

for i = 1:num_img_training
    immagini_tr{i} = imresize(immagini_tr{i}, target_size);
    immagini_gt{i} = imresize(immagini_gt{i}, target_size);
    immagini_test{i} = imresize(immagini_test{i}, target_size);
    immagini_gt_test{i} = imresize(immagini_gt_test{i}, target_size);
end

% Creo cell array per contenere le feature di ogni immagine
var_loc = cell(num_img_training, 1);
col_loc = cell(num_img_training, 1);
train_labels = cell(num_img_training, 1);

for i = 1:num_img_training
    im = immagini_tr{i};
    gt = immagini_gt{i};
    
    var = compute_local_var(im2double(rgb2gray(im)), finestra);
    col = compute_local_col(im, finestra);
    
    % Salvo le feature come vettori colonna per ogni immagine
    var_loc{i} = var(:);
    col_loc{i} = col(:);
    train_labels{i} = gt(:);
end

% Concateno tutte le feature e labels
X_var = cell2mat(var_loc);
X_col = cell2mat(col_loc);
Y = cell2mat(train_labels);

% Combino le due feature
X = [X_var, X_col];

% Creo il modello kNN
C = fitcknn(X, Y, 'NumNeighbors', 5);



% Calcolo e visualizzo le predizioni per le immagini di test
for i = 1:num_img_training
    test_var = compute_local_var(im2double(rgb2gray(immagini_test{i})), finestra);
    test_col = compute_local_col(immagini_test{i}, finestra);
    
    test_var_vec = test_var(:);
    test_col_vec = test_col(:);
    
    test_X = [test_var_vec, test_col_vec];
    
    pred_labels = predict(C, test_X);
    
    pred_image = reshape(pred_labels, target_size);
    
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
    cm_test = confmat(immagini_gt_test{i}, pred_labels);
    figure;
    show_confmat(cm_test.cm_raw, cm_test.labels);
    title("Test");

    fprintf('Test Accuracy: %f\n', cm_test.accuracy);
end

