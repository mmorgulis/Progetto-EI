# Progetto Riconoscitore di foglie
## Istruzioni:
1. Avviare le 3 funzioni "read_training_image", "read_test_image", "read_oth_image"
2. Avviare lo script "train_locator.mat" per allenare il modello di localizzazione (tempo 1/2 minuti)
3. Avviare lo script "train_classificator.mat" per allenare il modello di classificazione (tempo 1 minuto)
4. All'interno del main passare un'immagine (riga 9 im = ...) e attendere circa 30 secondi per il risultato

## Supposizioni:
Il riconoscitore funziona bene su sfondi omogenei, su sfondi differenti (legno, tessuti ecc) ha performance basse in quanto non riesce a localizzare in modo corretto le foglie.
Le foglie del dataset sono abbastanza diverse in quanto con poche foglie di training è molto difficile riconoscere foglie simili.
Le ground truth sono state create tramite Photoshop, in particolare si sono create delle maschere binarie selezionando l'area delle foglie.

## Dataset
Il dataset contiene 10 classi di foglie (oleandro, ciclamino, ulivo, rosmarino, prezzemolo, edera, alloro, quercia, lauroceraso, trifoglio) e per ogni classe sono presenti un totale di 20 foglie, di cui 14 per il training e 6 per il testing.
Per rendere il riconoscitore più robusto è stato addestrato anche con 5 sfondi diversi (tessuti e colori diversi).
Le foglie sono state catturate da un telefono con risoluzione 3080 * 4096 px con il flash per togliere eventuali ombre.

## Localizzatore
Si occupa di classificare se un pixel dell'immagine è sfondo oppure foglia.
Per allenare il localizzatore abbiamo usato diverse features sottoforma di maschera dell'intera immagine di foglie, in particolare la features sono:
* **Varianza locale con finestra di 11**
* **Saturazione**
* **Colore (media rgb)** 
* **Entropia locale (finestra di deafault = 9)**
* **Maschera di Gabor con wavelenght = 4 e orientamento = 90**
.. dettagli su se passo img grigia, cosa tornano ecc

### Errori localizzazione
Edera, Rosmarino Perchè? ...

## Classificatore
Cosa fa ..
Features:
media valori nelle classi e spiego perché sono discriminanti


### Errori classificazione

## Main
Labeling, soglie ecc

## Performance/Tempi



