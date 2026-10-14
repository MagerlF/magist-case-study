# Daten

Zwei Ebenen: die Rohtabellen aus der Magist-Datenbank und die aggregierten
Ergebnisse, aus denen die Diagramme entstanden sind.

## raw/

Die neun Tabellen der Datenbank als CSV, kommagetrennt, UTF-8.

| Datei | Zeilen | Inhalt |
|---|---|---|
| `orders.csv` | 99.441 | eine Zeile je Bestellung, mit allen Zeitstempeln |
| `order_items.csv` | 112.650 | eine Zeile je Artikel innerhalb einer Bestellung |
| `order_payments.csv` | 103.886 | Zahlungen je Bestellung |
| `order_reviews.csv` | 98.371 | Kundenbewertungen mit Kommentaren |
| `customers.csv` | 99.441 | Kunden mit Postleitzahl |
| `sellers.csv` | 3.095 | Verkäufer mit Postleitzahl |
| `products.csv` | 32.951 | Produktkatalog mit Maßen und Gewicht |
| `product_category_name_translation.csv` | 74 | Kategorienamen portugiesisch nach englisch |
| `geo.csv` | 19.177 | Postleitzahlen, Orte, Bundesstaaten, Koordinaten |

### Beziehungen

```
customers ──< orders ──< order_items >── products >── product_category_name_translation
                 │             │
                 │             └──> sellers
                 ├──< order_payments
                 └──< order_reviews

geo >── customers   (customer_zip_code_prefix)
geo >── sellers     (seller_zip_code_prefix)
```

### Hinweis für Tableau

`geo.csv` hängt an zwei Tabellen, an `customers` und an `sellers`. Tableau kommt
mit solchen Ringverbindungen nicht zurecht. Die Datei muss zweimal eingebunden
werden, etwa als `geo_customers.csv` und `geo_sellers.csv`. Es sind identische
Kopien.

Außerdem erkennt Tableau die beiden Beziehungen nicht automatisch, weil die
Spalten unterschiedlich heißen: `customer_zip_code_prefix` gegenüber
`zip_code_prefix`. Beide Verknüpfungen müssen von Hand gesetzt werden.

### Datenbank anlegen

```bash
mysql -u root -p -e "CREATE DATABASE magist;"
```

Danach die Tabellen anlegen und die CSVs importieren, etwa über den Import
Wizard in MySQL Workbench. Die Abfragen in `sql/` laufen gegen diese Datenbank.

## Aggregierte Daten

Die Tabellen, aus denen die Diagramme der Präsentation entstanden sind.
Semikolon als Trennzeichen, Komma als Dezimaltrennzeichen.

| Datei | Inhalt |
|---|---|
| `01_preisklassen_tech.csv` | Verkaufte Artikel je Preisklasse, getrennt nach Tech und Nicht-Tech |
| `03_lieferzeit_monat.csv` | Lieferdauer und Verspätungsquote je Monat |
| `04_bundeslaender.csv` | Lieferdauer, Verspätung und Bewertung je Bundesstaat |
| `05_lieferzeit_bewertung.csv` | Lieferdauer je Bewertungsstufe |
| `07_tech_kategorien.csv` | Verkäufe und Umsatz je Tech-Kategorie |
| `08_bewertungen_gesamt.csv` | Verteilung der Bewertungen |
| `09_preise_kategorien.csv` | Minimum, Maximum und Durchschnitt je Kategorie |
| `10_preissegmente_kategorien.csv` | Preissegmente innerhalb der Tech-Kategorien |

## Herkunft

Die Daten stammen aus dem Kursmaterial der Weiterbildung und bilden einen
Auszug aus Magists Datenbank ab, Zeitraum September 2016 bis Oktober 2018.
Magist ist ein fiktives Unternehmen.
