---
title: "Fallstudie Eniac × Magist — Analyseergebnisse"
kurs: "Data Science & AI"
modul: "Fallstudie 1"
typ: analyse
erstellt: 2026-10-05
status: entwurf
tags:
  - fallstudie
  - magist
  - analyse
  - sql
---

# 📊 Analyseergebnisse — Magist-Datenbank

> [!abstract] Datenbasis
> **99.441 Bestellungen** von **96.096 Kunden** bei **3.095 Verkäufern**,
> Zeitraum **September 2016 bis Oktober 2018**.
> 32.951 Produkte in 74 Kategorien, 112.650 verkaufte Artikel.
>
> Ausgewertet wurden die 96.470 Bestellungen mit Status `delivered` und
> vollständigem Lieferdatum.

> [!info] Währung
> Laut Aufgabenstellung sind **alle Preise in Euro**. Eine frühere Fassung
> dieser Notiz rechnete versehentlich in brasilianischen Real — die Zahlen
> sind dieselben, aber ihre Bedeutung ist eine deutlich andere: 75 Euro
> Medianpreis ist ein substanzielleres Preisniveau als 75 Real.

> [!warning] Alle Zahlen selbst nachrechnen
> Die Werte unten stammen aus meiner Auswertung des Dumps. Bevor sie in die
> Präsentation gehen, solltet ihr die zentralen Kennzahlen mit eigenen Queries
> gegenprüfen — nicht nur zur Sicherheit, sondern weil ihr sie in der Fragerunde
> verteidigen müsst.

---

## ⚖️ Bedenken 1 — Produktpassung

### Das Preisniveau

| Kennzahl | Wert (EUR) |
|---|---|
| Durchschnittspreis | **120,65** |
| Median (50. Perzentil) | **74,99** |
| 25. Perzentil | 39,90 |
| 75. Perzentil | 134,90 |
| 90. Perzentil | 229,80 |
| 99. Perzentil | 890,00 |
| Höchster Einzelpreis | 6.735,00 |

**Anteil hochpreisiger Artikel:**

| Schwelle | Artikel | Anteil |
|---|---|---|
| über 100 EUR | 40.313 | 35,8 % |
| über 200 EUR | 13.374 | 11,9 % |
| über 500 EUR | 3.216 | **2,9 %** |
| über 1.000 EUR | 844 | **0,8 %** |

> [!danger] Kernbefund 1
> **Magist ist ein Massenmarkt-Marktplatz.** Der mittlere Artikel kostet rund
> 75 Euro. Nicht einmal jeder dreißigste Artikel liegt über 500 Euro.
>
> Eniacs Sortiment — iPhones, Macs, iPads — liegt fast vollständig in einem
> Preissegment, das bei Magist **weniger als 1 % des Geschäfts** ausmacht.

### Die Kategorien

Top 5 nach Umsatz:

| Kategorie | Umsatz EUR | Anteil | Ø Preis |
|---|---|---|---|
| health_beauty | 1.258.681 | 9,3 % | 130,16 |
| watches_gifts | 1.205.006 | 8,9 % | 201,14 |
| bed_bath_table | 1.036.989 | 7,6 % | 93,30 |
| sports_leisure | 988.049 | 7,3 % | 114,34 |
| **computers_accessories** | 911.954 | **6,7 %** | 116,51 |

Die umsatzstärksten Kategorien sind Kosmetik, Uhren und Heimtextilien. Technik
taucht erst auf Platz fünf auf — und dort als **Zubehör**, nicht als Hardware.

### Das Tech-Segment im Detail

| Kategorie | Artikel | Umsatz EUR | Ø Preis | Max |
|---|---|---|---|---|
| computers_accessories | 7.827 | 911.954 | 116,51 | 3.700 |
| telephony | 4.545 | 323.668 | 71,21 | 2.428 |
| **computers** | **203** | 222.963 | **1.098,34** | 6.729 |
| small_appliances | 679 | 190.649 | 280,78 | 4.799 |
| electronics | 2.767 | 160.247 | 57,91 | 2.471 |
| consoles_games | 1.137 | 157.465 | 138,49 | 4.100 |
| fixed_telephony | 264 | 59.583 | 225,69 | 1.790 |
| audio | 364 | 50.689 | 139,25 | 599 |
| tablets_printing_image | 83 | 7.528 | 90,70 | 890 |
| pc_gamer | 9 | 1.546 | 171,77 | 239 |
| **Summe Tech** | **17.878** | **2.086.292** | | |

**Tech macht 15,9 % der Artikel und 15,3 % des Umsatzes aus.**

> [!important] Der entscheidende Vergleich
> Durchschnittspreis **Tech: 116,70 EUR** — Durchschnittspreis **alle anderen
> Kategorien: 121,40 EUR**.
>
> Technik ist bei Magist also **nicht** das Premium-Segment, sondern liegt sogar
> leicht unter dem Durchschnitt. Das widerlegt die naheliegende Hoffnung, Magists
> Elektronikerfahrung sei auf Eniac übertragbar.

> [!tip] Das Gegenargument, das man kennen sollte
> Die Kategorie `computers` enthält nur **203 verkaufte Artikel** — aber mit
> einem Durchschnittspreis von **1.098 EUR** und Spitzen bis 6.729 EUR.
>
> Hochpreisige Technik **wird** also über Magist verkauft. Die Frage ist nicht,
> ob es technisch geht, sondern ob die Menge reicht und ob die Zielgruppe passt.
> 203 Artikel in zwei Jahren sind ein Nischengeschäft, kein Markt.

---

## ⚖️ Bedenken 2 — Liefergeschwindigkeit

### Die Dauer

| Kennzahl | Tage |
|---|---|
| **Durchschnitt** | **12,6** |
| Median | 10,2 |
| Schnellste Lieferung | 1 |
| Langsamste Lieferung | 210 |
| 90. Perzentil | 23,1 |
| 95. Perzentil | 29,3 |
| 99. Perzentil | 46,1 |

| Geliefert innerhalb von | Anteil |
|---|---|
| 3 Tagen | **4,9 %** |
| 5 Tagen | 13,9 % |
| 7 Tagen | **27,0 %** |
| 10 Tagen | 48,2 % |
| 14 Tagen | 68,7 % |
| 30 Tagen | 95,3 % |

> [!danger] Kernbefund 2
> **Nur gut jede vierte Bestellung kommt innerhalb einer Woche an.** Für ein
> Unternehmen, das schnelle Lieferung als Markenversprechen führt, ist das der
> kritischste Einzelwert der gesamten Analyse.
>
> **8,1 %** aller Lieferungen überschreiten sogar das Magist selbst zugesagte
> Datum.

### Lieferzeit und Kundenzufriedenheit

| Bewertung | Anzahl | Ø Lieferdauer | davon verspätet |
|---|---|---|---|
| ⭐ 1 | 9.519 | 21,4 Tage | 37,9 % |
| ⭐⭐ 2 | 2.946 | 16,7 Tage | 20,7 % |
| ⭐⭐⭐ 3 | 7.901 | 14,3 Tage | 11,2 % |
| ⭐⭐⭐⭐ 4 | 18.780 | 12,3 Tage | 5,0 % |
| ⭐⭐⭐⭐⭐ 5 | 56.343 | **10,7 Tage** | 3,0 % |

Umgekehrt betrachtet:

| Lieferdauer | Ø Bewertung |
|---|---|
| 0–5 Tage | 4,44 ⭐ |
| 5–10 Tage | 4,36 ⭐ |
| 10–15 Tage | 4,26 ⭐ |
| 15–21 Tage | 4,11 ⭐ |
| 21–30 Tage | 3,60 ⭐ |
| **über 30 Tage** | **2,24 ⭐** |

> [!important] Die stärkste Zahl der Analyse
> **Pünktlich geliefert: 4,29 Sterne. Verspätet geliefert: 2,55 Sterne.**
> Eine Verspätung kostet **1,74 Sterne** — mehr als ein Drittel der Skala.
>
> Das ist der empirische Beleg dafür, dass Lieferzeit bei brasilianischen Kunden
> direkt auf die Zufriedenheit durchschlägt. Genau der Mechanismus, über den sich
> Eniac Sorgen macht — nur jetzt mit Zahlen belegt.

### Regionale Unterschiede

| Bundesland | Lieferungen | Ø Tage | Ø Sterne |
|---|---|---|---|
| **SP** (São Paulo) | 40.535 | **8,8** | 4,24 |
| MG | 11.362 | 12,0 | 4,18 |
| PR | 4.913 | 12,0 | 4,24 |
| … | | | |
| CE | 1.279 | 21,3 | 3,94 |
| MA | 718 | 21,6 | 3,80 |
| **PA** (Pará) | 948 | **23,8** | 3,90 |

> [!tip] Strategisch verwertbar
> Die Spanne reicht von 8,8 bis 23,8 Tagen. **São Paulo allein steht für 42 % aller
> Lieferungen** und liegt mit 8,8 Tagen deutlich über dem Rest.
>
> Das eröffnet eine Option jenseits von Ja/Nein: ein **regional begrenzter
> Markteintritt** im Südosten, wo Logistik und Kaufkraft stimmen, statt
> landesweiter Start.

### Entwicklung über die Zeit ⭐

| Monat | Bestellungen | Ø Tage |
|---|---|---|
| 2017-02 | 1.653 | 13,2 |
| 2017-08 | 4.193 | 11,1 |
| 2017-11 | 7.288 | 15,2 |
| 2018-02 | 6.555 | **16,9** |
| 2018-04 | 6.798 | 11,5 |
| 2018-06 | 6.096 | 9,2 |
| 2018-07 | 6.156 | 9,0 |
| **2018-08** | 6.351 | **7,7** |

> [!success] Das stärkste Argument *für* Magist
> Die Lieferzeiten haben sich **halbiert**: von 16,9 Tagen im Februar 2018 auf
> **7,7 Tage im August 2018** — bei gleichbleibendem Volumen.
>
> Der Durchschnittswert von 12,6 Tagen über den Gesamtzeitraum **unterschätzt
> Magists heutige Leistung erheblich**. Wer nur diese eine Zahl zeigt, bewertet
> Magist nach einem Stand, der längst überholt ist.
>
> Der Ausschlag im November/Dezember 2017 ist vermutlich das Weihnachtsgeschäft
> plus Black Friday — ein saisonales Muster, das sich wiederholen dürfte.

---

## 🧭 Einordnung

### Was für den Vertrag spricht

Die Lieferleistung verbessert sich deutlich und liegt zuletzt bei 7,7 Tagen.
Magist bewältigt knapp 100.000 Bestellungen und 3.095 Verkäufer — die
Infrastruktur trägt. Im Südosten sind die Lieferzeiten schon jetzt konkurrenzfähig.
Hochpreisige Technik wird nachweislich abgewickelt, bis 6.729 EUR pro Artikel.
Und für einen Markttest ohne eigene Infrastruktur gibt es keine schnellere Option.

### Was dagegen spricht

Der mittlere Artikel kostet 75 EUR — Magists Kundschaft und Sortiment sind ein
anderes Marktsegment als Eniacs. Nur 2,9 % der Artikel liegen über 500 EUR.
Technik ist bei Magist kein Premium-Segment, sondern liegt preislich sogar unter
dem Durchschnitt. Nur 27 % der Lieferungen erreichen den Kunden binnen einer
Woche. Und Verspätungen kosten 1,74 Sterne — bei einer Marke, die von
Kundenzufriedenheit lebt, ist das teuer.

### Die ehrliche Einschränkung

> [!warning] Was die Daten *nicht* sagen
> Die Zahlen beschreiben **Magists bisherige Kunden**: kleine und mittlere
> brasilianische Händler mit günstigen Alltagsprodukten. Eniac wäre ein anderer
> Kundentyp mit anderem Sortiment, anderer Zielgruppe und anderen Erwartungen.
>
> Ob Magists Logistik auch bei teurer, diebstahlgefährdeter Elektronik
> funktioniert, lässt sich aus diesen Daten **nicht** beantworten — dafür gibt es
> schlicht zu wenige Fälle. Diese Lücke selbst anzusprechen ist stärker, als sie
> vorgehalten zu bekommen.

---

## 📁 Daten für Tableau

Im Ordner `daten/` liegen sieben CSV-Dateien, direkt importierbar:

| Datei | Inhalt | Diagrammvorschlag |
|---|---|---|
| `01_kategorien_umsatz.csv` | alle 74 Kategorien | Balken, Top 10 |
| `02_preisklassen.csv` | 6 Preisklassen | Säulen oder Treemap |
| `03_lieferdauer_verteilung.csv` | Lieferungen je Tag | Histogramm |
| `04_lieferdauer_pro_monat.csv` | Zeitverlauf | **Liniendiagramm** |
| `05_lieferdauer_vs_bewertung.csv` | Sterne ↔ Dauer | Balken mit zwei Achsen |
| `06_bundeslaender.csv` | 28 Bundesstaaten | **Karte** |
| `07_tech_kategorien.csv` | 10 Tech-Kategorien | Balken |

> [!tip] Die drei Diagramme für die Präsentation
> Bei 4 Minuten reichen drei. Meine Empfehlung:
>
> **`04`** als Liniendiagramm — der Verbesserungstrend ist die überraschendste
> Erkenntnis und das zentrale Argument.
>
> **`02`** als Säulen — zeigt in einem Blick, dass Eniacs Preissegment bei
> Magist praktisch nicht vorkommt.
>
> **`05`** — belegt, dass Lieferzeit direkt die Zufriedenheit bestimmt.

---

## 🔗 Verknüpfungen

- [[Fallstudie Eniac x Magist - Briefing]] — Aufgabenstellung und Vorgehen
- [[MOC - SQL]]
