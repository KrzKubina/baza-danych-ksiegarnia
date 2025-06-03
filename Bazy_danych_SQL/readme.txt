#  System bazy danych dla księgarni internetowej (SQL)

Projekt przedstawia kompletną relacyjną bazę danych dla księgarni internetowej. Obejmuje projekt tabel, relacje, zapytania analityczne, widoki, funkcje, procedury i triggery.

##  Struktura bazy danych

Projekt zawiera 11 tabel logicznie powiązanych ze sobą, m.in.:
- `klienci`, `zamowienia`, `koszyk` – obsługa zamówień i klientów
- `ksiazki_info`, `ksiazki_oceny`, `ceny`, `magazyn` – zarządzanie książkami i dostępnością
- `status_dostawy`, `klienci_kurier`, `logowanie` – logistyka i statusy przesyłek
- `epoki` – klasyfikacja książek wg epoki historycznej

Relacje zostały odwzorowane na diagramie.