clear;
close all;

load("locator.mat"); 
load("im_training.mat");

[train_labels] = read_tr(); % leggo file delle etichette

features = [];
labels = [];
num_comp_conn = 14;

% Per ogni img trovo le foglie con il localizzatore
% e alleno il classificatore
for i = 1:num_img_training
    im = immagini_tr(:,:,:,i);
    gt = im2double(immagini_gt(:,:,i));
    % Se non avessi le gt :
    % leaf = localize_leaf(im);
    % leaf_labels = bwlabel(leaf);
    leaf_labels = bwlabel(gt);
    area = regionprops(leaf_labels, 'Area');
    filter = find([area.Area] >= 300); % potrebbe esserci del rumore
    labels_filtered = ismember(leaf_labels, filter);
    labels_final = bwlabel(labels_filtered);
    num_comp_conn = max(max(labels_final));
    
    % Le componenti connesse devono essere 14, cioè il numero delle
    % foglie di train per immagine
    if (num_comp_conn ~= 14)
        figure, imagesc(labels_final), axis image, colorbar;
        error("Errore numero componenti connesse");
    end

    % Per ogni componente connessa calcolo features
    for j = 1:num_comp_conn
        foglia_bin = labels_final == j;
        foglia_bin_3d = repmat(foglia_bin, [1 1 3]);
        foglia_rgb = im .* uint8(foglia_bin_3d);
        features_foglia = compute_all_class_features(foglia_rgb);
        features_reshaped = reshape(features_foglia, 1, []);
        features = [features; features_reshaped];
    end
end

% Stampo media classi
num_classi = 10;  
medie_classi = zeros(10, 18);  % Matrice risultante 10x18

% Calcola la media per ogni blocco di 14 righe
for i = 1:num_classi
    inizio_riga = (i-1)*14 + 1;     % Prima riga del blocco
    fine_riga = i*14;               % Ultima riga del blocco
    medie_classi(i,:) = mean(features(inizio_riga:fine_riga,:));
end

X = features;
Y = train_labels;

% Cl = fitcknn(X, Y, 'NumNeighbors', 7);

% Cl = fitctree(X, Y, ...
%     'MaxNumSplits', 100, ...     % Limite profondità
%     'PruneCriterion', 'error');

Cl = TreeBagger(50, X, Y, ...
    'Method', 'classification', ...
    'MinLeafSize', 3, ...           % Minimo nodi foglia
    'MaxNumSplits', 50, ...         % Ridotto per evitare overfitting
    'NumPredictorsToSample', 'all', ... % Prova tutti i predittori dato il dataset piccolo
    'OOBPrediction', 'on', ...      % Abilita Out-of-Bag error
    'OOBPredictorImportance', 'on' ); % Calcola l'importanza delle feature

% % Visualizzo errore Out-of-Bag
% figure
% oobError = oobError(Cl);
% plot(oobError)
% xlabel('Numero di alberi')
% ylabel('Out-of-bag error')
% 
% % Visualizzo importanza delle feature
% imp = Cl.OOBPermutedPredictorDeltaError;
% figure
% bar(imp)
% xlabel('Features')
% ylabel('Importanza stimata')

predicted_train = predict(Cl, X);
cm_train = confmat(Y, predicted_train);
figure(1);
show_confmat(cm_train.cm_raw, cm_train.labels);
title("Recall");
fprintf('Train Accuracy: %f\n', cm_train.accuracy);

save("classificator.mat", "Cl");