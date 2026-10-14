/*
*******************************************************************************
*******************************************************************************

MAGIST 1 - ERSTE ERKUNDUNG

*******************************************************************************
*******************************************************************************

Klauseln: SELECT, FROM, GROUP BY, ORDER BY, COUNT, MIN, MAX, DISTINCT,
          YEAR(), MONTH()

Tabellen: orders, order_items, order_payments, order_reviews, products,
          product_category_name_translation, customers, sellers, geo
*/

USE magist;


-- 1. Wie viele Bestellungen enthaelt der Datensatz?
--    Die orders-Tabelle hat eine Zeile pro Bestellung.

SELECT COUNT(*) AS bestellungen
FROM orders;

		-- 99.441 Bestellungen



/* 2. Werden die Bestellungen tatsaechlich zugestellt?
   In orders gibt es die Spalte order_status. Die meisten scheinen zugestellt,
   einige nicht. Nach dieser Spalte gruppieren und zaehlen. */

SELECT order_status,
       COUNT(*) AS anzahl,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS prozent
FROM orders
GROUP BY order_status
ORDER BY anzahl DESC;

		-- delivered 96.478 (97,0 %), shipped 1.107, canceled 625,
		-- unavailable 609, invoiced 314, processing 301, created 5, approved 2
		-- 97 % kommen an, nur 0,6 % werden storniert



/* 3. Waechst Magist?
   Anzahl Bestellungen nach Jahr und Monat aufschluesseln.
   Tipp: YEAR() und MONTH() auf order_purchase_timestamp. */

SELECT YEAR(order_purchase_timestamp) AS jahr,
       MONTH(order_purchase_timestamp) AS monat,
       COUNT(*) AS bestellungen
FROM orders
GROUP BY jahr, monat
ORDER BY jahr, monat;

		-- deutliches Wachstum: 01/2017 noch 800, ab 01/2018 ueber 7.000
		-- Spitze 11/2017 mit 7.538 (Black Friday)
		-- ACHTUNG: 09/2016 (4), 12/2016 (1), 09/2018 (16), 10/2018 (4)
		-- sind praktisch leer, 11/2016 fehlt ganz



-- 4. Wie viele Produkte stehen in products? (keine Duplikate zaehlen)

SELECT COUNT(DISTINCT product_id) AS produkte
FROM products;

		-- 32.951 Produkte, keine Duplikate (COUNT(*) liefert dasselbe)



/* 5. Welche Kategorien haben die meisten Produkte?
   Produktnamen sind anonymisiert, Kategorien kennen wir aber. Zeilen in
   products zaehlen, nach Kategorie gruppieren.
   Achtung: das sind angebotene, nicht verkaufte Produkte. */

SELECT pt.product_category_name_english AS kategorie,
       COUNT(*) AS produkte
FROM products p
JOIN product_category_name_translation pt USING (product_category_name)
GROUP BY kategorie
ORDER BY produkte DESC;

		-- Top 5: bed_bath_table 3.029, sports_leisure 2.867,
		-- furniture_decor 2.657, health_beauty 2.444, housewares 2.335
		-- Technik taucht erst auf Platz 7 auf: computers_accessories 1.639
		-- Magist ist ein Massenmarkt fuer Haushalt und Freizeit



/* 6. Wie viele davon kamen in echten Bestellungen vor?
   products ist der Gesamtkatalog. In order_items nachsehen. */

SELECT COUNT(DISTINCT product_id) AS verkaufte_produkte
FROM order_items;

		-- 32.951 - alle Produkte des Katalogs wurden mindestens einmal verkauft
		-- keine Karteileichen im Sortiment



-- 7. Teuerstes und guenstigstes Produkt?

SELECT MIN(price) AS guenstigstes,
       MAX(price) AS teuerstes,
       ROUND(AVG(price), 2) AS schnitt
FROM order_items;

		-- 0,85 EUR bis 6.735,00 EUR, Schnitt 120,65 EUR
		-- riesige Spanne, aber der Median liegt nur bei 74,99 EUR



/* 8. Hoechster und niedrigster Zahlungsbetrag?
   Manche Bestellungen enthalten mehrere Produkte. In order_payments nachsehen. */

SELECT MIN(payment_value) AS niedrigster,
       MAX(payment_value) AS hoechster
FROM order_payments;

		-- 0,00 EUR bis 13.664,10 EUR
		-- der Hoechstwert liegt ueber dem teuersten Einzelprodukt (6.735),
		-- weil eine Bestellung mehrere Artikel enthalten kann
		-- 9 Zahlungen mit 0,00 EUR - vermutlich Gutscheine oder Stornos



/*
-------------------------------------------------------------------------------
NOTIZEN

Zeitraum:   09/2016 - 10/2018 = 25 Monate, davon 4 Randmonate fast leer.
            Belastbar: 01/2017 - 08/2018 = 20 Monate.

Wachstum:   klar steigend, von 800 Bestellungen (01/2017) auf ueber 7.000
            (01/2018). Spitze im November 2017 durch Black Friday.

Sortiment:  32.951 Produkte in 74 Kategorien, alle mindestens einmal verkauft.
            Schwerpunkt Haushalt, Sport, Moebel, Beauty. Technik erst auf
            Platz 7.

Preise:     0,85 bis 6.735 EUR, Schnitt 120,65, Median 74,99.
            Zahlungen bis 13.664 EUR (Mehrartikel-Bestellungen).

Offen:      - Wie viel von der Technik ist hochpreisig? (-> Teil 2)
            - Wie lange dauern die Lieferungen? (-> Teil 2)
            - Was bedeuten die 9 Zahlungen ueber 0,00 EUR?
-------------------------------------------------------------------------------
*/
