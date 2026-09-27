# Anforderungen

Grundlage: bestätigte Nutzeranweisungen vom 27.09.2026. Diese Anforderungen beschreiben das eigenständige Repository `KI-Englischlehrerin`.

## Anwendung

- Das Projekt wird als eigenständiges Repository entwickelt und veröffentlicht. Änderungen und Prüfdateien bleiben innerhalb von `KI-Englischlehrerin`.
- Live-Gespräche unterstützen OpenAI und Gemini mit jeweils eigenen Modellen und Stimmen.
- Das Unterrichts-Backend unterstützt OpenAI und DeepSeek. OpenAI-Denkintensität und Dienstpriorität (`auto` / `fast`) sind konfigurierbar.
- Aufnahmen zur Vorbereitung werden unabhängig von Live über OpenAI oder Gemini transkribiert.
- Der Vorbereitungsassistent unterstützt OpenAI, Gemini und DeepSeek für Gespräche, Themenpflege und Unterrichtspläne. Modelle und Denkstufen sind unabhängig konfigurierbar; Gemini verwendet seinen nativen API-Adapter.
- Schlüssel werden ausschließlich aus den System- bzw. Prozessumgebungsvariablen des jeweiligen Anbieters gelesen, einschließlich vorhandener Windows-Variablen. Lokale `.env`-Schlüssel, Eingabefelder für Schlüssel und automatische Anbieterwechsel sind ausgeschlossen.
- Deutsche Oberfläche, englische Lerninhalte, chinesische Vorbereitungsgespräche, Themen- und Unterrichtsplanverwaltung sowie der direkte Start gespeicherter Pläne bleiben erhalten. Das gilt ebenso für Rückmeldungen zu Klick- und Sprachantworten, selbstständiges Fortsetzen, Vorrang neuer Kinderäußerungen, Sprechtempo und Lernaufzeichnungen.
- Standardmäßig liegen lokale Daten unter `data/`: SQLite-Datenbank `learning.sqlite`, Bilder unter `images/` und gespeicherte Anbieterauswahl in `model-settings.json`.
- Kommentierte `.env` und `.env.example`, Start- und Stoppskripte, README, Prüfprotokoll und `.gitignore` gehören zum Projekt.

Prüfziele sind Konfigurations- und Schlüsseltrennung für 24 Anbieterkombinationen, Lebenszyklen beider Live-Verbindungen, drei Vorbereitungsadapter, zwei Transkriptionswege, Fehler und Abbruch, Unterrichtsabläufe sowie zuverlässige Speicherung und Wiederherstellung lokaler Lernaufzeichnungen. Simulationen und echte API- bzw. Mikrofonprüfungen werden getrennt dokumentiert.

## Einstellungen im laufenden Betrieb

- Änderungen erfolgen ausschließlich in `KI-Englischlehrerin`. Bestehende lokale `.env`-Dateien werden nicht zur Beschaffung von Schlüsseln gelesen.
- Das Zahnrad oben rechts bietet unabhängige Anbieterlisten für Live, Unterrichts-Backend, Spracheingabe und Gespräche mit Unterrichtsplan. Die verfügbaren Anbieter bleiben unverändert.
- Nur **Anbieter** ist bearbeitbar. Modell, Denkintensität, Stimme und Dienstpriorität werden aus der Umgebung angezeigt und sind weder über die Oberfläche noch über die Speicher-API veränderbar.
- OpenAI für **Gespräche & Unterrichtsplan** verwendet immer `auto`. Nur das OpenAI-Backend liest seine Dienstpriorität aus der Umgebung. `OPENAI_TEACHER_SERVICE_TIER` wird ignoriert.
- Eine Auswahl bleibt bis **Speichern** ein Entwurf. **Abbrechen**, Speicherfehler, ungültige Konfigurationen und Speicherversuche veralteter Fenster ändern die bisherige Konfiguration nicht.
- Dauerhaft gespeichert werden nur die vier Anbieter. Modellparameter älterer Einstellungsdateien gelten nicht mehr. Parameter stammen immer aus der Umgebung und werden nach einer Änderung an `.env` durch Neustart aktualisiert. Auch **Standardwerte** muss gespeichert werden.
- Laufende Stunden, Vorbereitung, Planerstellung und Transkription werden geschützt. Nach deren Abschluss lässt sich speichern; neue Aufrufe verwenden die neue Auswahl ohne Dienstneustart.

## Deutsche Oberfläche und Veröffentlichung

Ergänzende Nutzeranweisung vom 27.09.2026:

- Ausschließlich innerhalb von `KI-Englischlehrerin` arbeiten.
- Alle festen Oberflächentexte einschließlich Navigation, Überschriften, Schaltflächen, Formularbeschriftungen und Sprachauswahl sind auf Deutsch.
- Alle eigenen Markdown-Dokumente sind auf Deutsch. Englische Lerninhalte, Namen und technische Bezeichner bleiben erhalten; automatisch installierte Abhängigkeitsdokumentation wird nicht verändert.
- Chinesische Chatnachrichten und chinesische Spracheingabe bleiben erlaubt. Die Oberflächensprache beschränkt keine Nutzereingaben oder Antworten im Vorbereitungsgespräch.
- `.gitignore` aktualisieren und den zur Veröffentlichung vorgesehenen Git-Index auf Schlüssel sowie lokale oder erzeugte Dateien prüfen.
- Nach erfolgreicher Prüfung committen und nach `https://github.com/wanzhikid123/KI-Englischlehrerin.git` pushen.
