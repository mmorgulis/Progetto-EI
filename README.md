# Progetto Riconoscitore di foglie
## Istruzioni:
1. Avviare le 3 funzioni "read_training_image", "read_test_image", "read_oth_image"
2. Avviare lo script "train_locator.mat" per allenare il modello di localizzazione (tempo 1/2 minuti)
3. Avviare lo script "train_classificator.mat" per allenare il modello di classificazione (tempo 1 minuto)
4. All'interno del main passare un'immagine (riga 9 im = ...) e attendere circa 30 secondi per il risultato

## Supposizioni:
Il riconoscitore funziona bene su sfondi omogenei, su sfondi differenti (legno, tessuti ecc) ha performance basse in quanto non riesce a localizzare in modo corretto le foglie.
Le foglie del dataset sono abbastanza diverse in quanto con poche foglie di training è molto difficile riconoscere foglie simili.
Le ground truth sono state create tramite Photoshop, in particolare si sono create delle maschere binarie selezionando l'area delle foglie e separando il livello di sfondo con quello delle foglie.

## Dataset
Il dataset contiene 10 classi di foglie (oleandro, ciclamino, ulivo, rosmarino, prezzemolo, edera, alloro, quercia, lauroceraso, trifoglio) e per ogni classe sono presenti un totale di 20 foglie, di cui 14 per il training e 6 per il testing.
Per rendere il riconoscitore più robusto è stato addestrato anche con 5 sfondi diversi (tessuti e colori diversi).
Le foglie sono state catturate da un telefono con risoluzione 3080 * 4096 px con il flash per togliere eventuali ombre.
Sulle immagini è stata effettuata una resize a 1064 * 1064 per aumentare la velocità del localizzatore e classificatore.

## Localizzatore
Si occupa di classificare se un pixel dell'immagine è sfondo oppure foglia.
Per allenare il localizzatore sono state usate diverse features sottoforma di maschera dell'intera immagine di foglie, in particolare la features sono:
* **Varianza locale con finestra di 11**
* **Saturazione**
* **Colore (media rgb)** 
* **Entropia locale (finestra di deafault = 9)**
* **Maschera di Gabor con wavelenght = 4 e orientamento = 90**
Riassumendo ogni pixel delle immagini di training è caratterizzato da 5 valori e il classificatore knn si è allenato su questi vettore 5-dimensionali per ogni punto.

### Errori localizzazione
Le foglie più difficili da localizzare sono edera e rosmarino.
Gli errori sull'edera sono dovuto al fatto che il colore e la texture della singola foglia è molto variabile, quindi in alcuni punti
può confondere il localizzatore. Per quanto riguarda il rosmarino l'errore potrebbe essere dovuto alla sottigliezza della foglia e 
alla qualità dell'immagine di test.

## Classificatore
Il classificatore predice le classi a cui ciascuna foglia appartiene. Per quanto riguarda il funzionamento inizialmente prende le 
ground truth binarie delle foglie, estrae le singole foglie e per ognuna ne calcola le features.
In particolare le features sono 18 e sono state scelte in modo da essere un set minimo e discriminante. Esse sono:
* **Shape**
    - ratio (lato minore / lato maggiore)
    - eccentricità $$\sqrt{1- ratio*ratio}
    - circolarità
    - rettangolarità
    - perimetro / lato_maggiore
    - perimetro / (lato maggiore + lato minore)
    - area / area bounding box
    - solidità
* **Media hue**
* **Media saturation**
* **2 maschere gabor con orientazione diversa**
* **Contrasto e Correlazione da glcm**
* **Media lbp**
* **Media entropia locale**
* **Deviazione standard locali**

Estraendo i valori medi delle classi si può notare che ogni classe ha valori diversi su queste features, quindi si può concludere che sono tutte discriminanti.
Il classificatore utilizzato è un random forest (con parametri ottimizzati in base al dataset).

### Errori classificazione
Gli errori dipendono dal random forest, ma in generale gli errori più comuni sono stati riscontrati sono tra foglie simili, in particolare tra ulivo e oleandro e tra edera/trifoglio/prezzemolo. Le performance del classificatore variano in base al random forest, ma in generale la recall ha precisione di 99%/100% e la precision varia tra 85%/95% per una media di 90%.

## Main
Innanzitutto lo script carica i modelli necessari per localizzazione e classificazione, successivamente localizza le foglie con la funzione localize_leaf e infine le classifica (facendo la predizione sul modello). Se la confidenza del random forest è inferiore al 50% la foglia viene classificata come unknown. Infine viene mostrata l'immagine iniziale con scritti sui centroidi delle foglie le classi previste.




