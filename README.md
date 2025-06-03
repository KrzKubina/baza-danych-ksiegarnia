#  System bazy danych dla księgarni internetowej (SQL)

Projekt przedstawia kompletną relacyjną bazę danych dla księgarni internetowej. Obejmuje projekt tabel, relacje, zapytania analityczne, widoki, funkcje, procedury i triggery.

##  Struktura bazy danych

Projekt zawiera 11 tabel logicznie powiązanych ze sobą, m.in.:
- `klienci`, `zamowienia`, `koszyk` – obsługa zamówień i klientów
- `ksiazki_info`, `ksiazki_oceny`, `ceny`, `magazyn` – zarządzanie książkami i dostępnością
- `status_dostawy`, `klienci_kurier`, `logowanie` – logistyka i statusy przesyłek
- `epoki` – klasyfikacja książek wg epoki historycznej

Relacje zostały odwzorowane na diagramie ERD (załączony obrazek).

##  Przykładowe zapytania SQL (JOIN + GROUP BY)

- Lista 10 najlepiej ocenianych książek
- Klienci z ich zamówionymi tytułami
- Dostępność książek w magazynie
- Lista zamówień z pełnym adresem dostawy
- Książki sprzedane + ich status magazynowy

##  Triggery

- Aktualizacja stanu magazynu przy dodaniu do koszyka
- Automatyczne generowanie loginu
- Przypisywanie epoki do książki na podstawie roku wydania

##  Procedury

- Wyszukiwanie klientów po nazwisku
- Lista klientów nieaktywnych przez 30 dni
- Przydzielanie zniżek klientom związanym z serią „Harry Potter”

##  Funkcje

- Liczenie klientów wg nazwiska
- Liczba książek wydanych w konkretnym roku
- Średnia ocena książki

##  Widoki

- Historia zamówień (`vhistoria_zamowien`)
- Top 10 klientów wg liczby zamówień (`vtop_klientow`)
- Książki dostępne w magazynie (`vdostepne_ksiazki`)
