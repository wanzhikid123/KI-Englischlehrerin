# Prüfprotokoll

Datum: 27.09.2026. Alle Änderungen liegen in `KI-Englischlehrerin`. Die ersten Abschnitte übersetzen das bestehende historische Protokoll; neue Prüfungen zur deutschen Oberfläche werden gesondert ergänzt.

## Ursprungsprojekte und Datenbank

- Vor der Zusammenführung wurden SHA-256-Prüfsummen von 76 Quelldateien aus EnglishLehrer und 93 aus EnglishLehrerGemini einschließlich Konfiguration und Dokumentation erfasst. Die abschließende Prüfung aller 169 Dateien ergab keine Änderung. Die ursprünglichen `.git`-Verzeichnisse wurden weder kopiert noch verändert.
- `server/store.js` entsprach dem ursprünglichen EnglishLehrer bytegenau; das Datenbankschema blieb bei Version 4.
- SQLite-Datei und WAL-/SHM-Begleitdateien wurden ausschließlich nach `.cache/compatibility-snapshot` kopiert. Geöffnet wurde nur diese Kopie; die Originaldatenbank wurde nicht über SQLite geöffnet und nicht in das standardmäßige `data` importiert.
- Die Kopie lieferte `PRAGMA integrity_check=ok`. Der Vergleich aller Tabellen und Zeilen vor und nach dem Öffnen war identisch: 18 Themen, 12 Unterrichtspläne, 9 Stunden, 167 Antworten, 153 Fragen, 49 unterrichtete Einträge, 3 Vorbereitungsnachrichten, 5 historische Bildeinträge und die übrigen Zustandstabellen blieben erhalten.
- Temporäre Kopien, Startprüfdaten und Verzeichnisse zum Prüfen der Ausschlussregeln blieben in der ignorierten `.cache`. Die damalige automatische Genehmigungsprüfung blockierte das abschließende Löschen; es wurde kein anderer Löschweg verwendet.
- Der neue Datenspeicher konnte Themen, Pläne, frühere Stunden und Lernergebnisse der Kopie lesen. Die URL-Zuordnung des Bildverzeichnisses blieb erhalten. Für eine spätere Übernahme ist das vollständige `data` zu kopieren; siehe README.

## Automatisierte Prüfungen der Zusammenführung

- 124 Node-Prüfungen bestanden, darunter 24 Anbieterkombinationen, Schlüsseltrennung, Groß- und Kleinschreibung, Vorrang von Umgebungsvariablen, ungültige Konfigurationen sowie Schreibschutz für Originalverzeichnisse und Verzeichnisverknüpfungen.
- Drei Vorbereitungswege wurden geprüft: native Gemini-Werkzeugaufrufe mit Denksignaturen sowie Themenpflege, Planerstellung und Werkzeugantworten über OpenAI und DeepSeek.
- Unterrichtsantworten wurden auf Denkinhalte im Speicher, passende Werkzeug-IDs, Abbruch und verspätete Antworten geprüft. Fehlende Schlüssel verhindern den Live-Start, unvollständige Antworten führen keine Werkzeuge aus, und Anbieterfehler geben keine Anfrageinhalte preis.
- OpenAI-Backend `fast` und Vorbereitungsassistent `auto` wurden unabhängig übergeben. DeepSeek-Anfragen enthalten weder OpenAI-Dienstpriorität noch die Anforderung verschlüsselter Denkinhalte.
- OpenAI- und Gemini-Transkription wurden zu Audio Transcriptions bzw. Interactions geleitet; Aufnahmeprüfung und Abbruchverhalten blieben erhalten.
- 27 Browserprüfungen bestanden: 26 bestehende Unterrichts-, Vorbereitungs-, Aufnahme- und PCM-Prüfungen sowie eine zusätzliche Prüfung von OpenAI-WebRTC-Auswahl, SDP-Versand, Untertiteln, Stummschaltung und Medienfreigabe.
- Die Produktionsoberfläche wurde erfolgreich erstellt. OpenAI- und Gemini-Browserverbindungen liegen in getrennten Codepaketen.
- Windows-Start, Zustandsabfrage und Beenden bestanden mit eigenem Prüfport und `.cache`-Datenverzeichnis. Das Stoppskript prüft weiterhin die Verzeichnisidentität.
- `.gitignore` schloss `.env`, Datenbanken mit Begleitdateien, Abhängigkeiten, erzeugte Dateien, Cache, Sicherungen, Berichte und private Schlüssel aus. `.env.example` und README blieben versionierbar. Die damalige Quellprüfung fand keine echten Schlüssel; `.env` entsprach einer Vorlage mit leeren Schlüsseln.

## Historische Prüfungen echter Dienste

- Mit Systemschlüsseln wurde der Modellzugriff abgefragt: OpenAI `gpt-live-1`, `gpt-6-luna` und `gpt-transcribe` sowie Gemini `gemini-3.8-live`, `gemini-3.5-flash-lite` und `gemini-3.5-transcribe` waren erreichbar.
- Echte Werkzeugaufrufe über zwei Runden mit synthetischen Daten bestanden: OpenAI-Backend `gpt-6-luna` / low / fast, OpenAI-Vorbereitung `gpt-6-luna` / high / auto und Gemini-Vorbereitung `gemini-3.5-flash-lite` / high.
- `DEEPSEEK_API_KEY` fehlte auf dem Rechner. Beide DeepSeek-Rollen bestanden simulierte Adapter- und Fachlogikprüfungen; echte DeepSeek-Aufrufe wurden nicht geprüft.
- Die echten Abfragen verwendeten nur synthetische Texte oder Modellmetadaten und sendeten keine Unterrichtsdaten aus der Originaldatenbank.

## Grenzen der bisherigen Prüfung

Eine echte Kinderstunde, physische Mikrofone und Lautsprecher, Spracherkennung bei Lärm, Safari/iPad und lange Live-Sitzungen wurden nicht abgenommen. Modellzugriffsabfragen ersetzen diese Prüfungen nicht. OpenAI-Browserprüfungen verwenden einen simulierten Transport; Gemini-Audioprüfungen verwenden echte Browser-AudioWorklets und lokale WebSockets mit einem simulierten Modelldienst.

Zum Abschluss der ursprünglichen Zusammenführung gab es keinen Commit, keinen Push und keine Bereitstellung im Internet. Beide Ursprungsanwendungen blieben unabhängig nutzbar; das neue Projekt verwendet standardmäßig Port 3212. Spätere Anbieterwechsel und die Quellcodeveröffentlichung werden separat dokumentiert.

## Erste Fassung der Online-Einstellungen

Diese historische Fassung vom 27.09.2026 erlaubte noch das Bearbeiten von Modellparametern. Sie wurde durch den folgenden Abschnitt ersetzt.

- Änderungen, temporäre Prüfverzeichnisse, npm-Cache, Bilder und Protokolle lagen ausschließlich in diesem Projekt. Die bestehende `.env` wurde weder zur Schlüsselbeschaffung gelesen noch verändert. Schlüssel wurden nur aus Prozessumgebungsvariablen gelesen; Schlüsselwerte in `.env` wurden ignoriert.
- Das Zahnradfenster bot zunächst Anbieter, Modelle und passende Parameter für vier Rollen. Geprüft wurden Vorgaben beim Anbieterwechsel, Entwürfe je Anbieter, Abbrechen, gemeinsames Speichern, Fortbestand nach Neuladen, ausdrücklich zu speichernde Standardwerte und Entwurfserhalt nach Speicherfehlern.
- Die erste Einstellungsdatei enthielt nur `provider`, `model`, `voice`, `reasoningEffort` und `serviceTier`. Datei und öffentliche Antwort enthielten keine Prüfschlüssel. Nach Neustart wurden Auswahl und Umgebungsschlüssel erneut verwendet.
- Geprüft wurden alle vier Aufrufwege, Parameter- und Schlüsseltrennung, Ablehnung ungültiger Kombinationen und zusätzlicher Schlüsselfelder, Konflikte veralteter Fenster, Erhalt alter Dienste bei Schreibfehlern und Schutz laufender Aufrufe, Stunden, Vorbereitungen und Pläne.
- Node-Gesamtprüfung: **128 / 128 bestanden**, Protokoll `.cache/model-settings-node-tests.log`.
- Abschließende Playwright-Gesamtprüfung: **30 / 30 bestanden**, Protokoll `.cache/model-settings-browser-final.log`. Erfasst wurden beide Live-Verbindungen, echte Browser-AudioWorklets, lokale PCM-Verarbeitung, Aufnahmen, Unterricht und Einstellungen. Ein zwischenzeitlicher Audioverbindungsfehler trat während einer parallelen Neuerstellung auf. Er galt nicht als bestandene Prüfung; anschließend bestanden 2 / 2 getrennte Audioprüfungen und eine vollständige Prüfung ohne parallele Neuerstellung mit 30 / 30. Eine eindeutige Ursache des ersten Fehlers wurde nicht bestätigt.
- Das Einstellungsfenster hatte bei 1280×620 und 390×844 keinen horizontalen Überlauf. Tab blieb im Fenster, Escape schloss es und gab den Fokus ans Zahnrad zurück. Die Bilder wurden visuell geprüft.
- Die Produktionsoberfläche wurde erstellt. Nach Bestätigung, dass keine Stunde oder Vorbereitung aktiv war, wurde der Dienst neu gestartet. `http://127.0.0.1:3212/api/settings` lieferte Status 200, vier Konfigurationen und `Cache-Control: no-store`, ohne Schlüsselwerte. Die aktuelle Anbieterauswahl wurde nicht geändert.
- Diese Runde rief keine echten kostenpflichtigen Modelle auf und prüfte weder physische Mikrofone noch Kinderstunden oder echte Parameterkombinationen. Die vorstehenden echten Dienstprüfungen stammen aus der Zusammenführung.

## Nur Anbieter sind bearbeitbar

Änderung vom 27.09.2026:

- Die Einstellungen enthalten nur vier Anbieterlisten. Modell, Stimme, Denkintensität und Dienstpriorität werden ausschließlich angezeigt; ein Anbieterwechsel zeigt die Umgebungsvorgaben dieser Rolle.
- Die Speicher-API lehnt zusätzliche Felder wie `model`, `voice`, `reasoningEffort`, `serviceTier`, `apiKey` und `baseUrl` ab. Neue Dateien speichern nur vier Anbieter. Alte Dateien liefern nur ihre Anbieter; frühere Parameterüberschreibungen werden ignoriert. Nach Neustart gelten aktualisierte Umgebungsparameter, Schlüssel kommen weiterhin nur aus System- bzw. Prozessvariablen.
- Die OpenAI-Vorbereitung verwendet fest `auto`. Werte `fast` und ungültige Werte aus Prüfdateien oder Systemvariablen konnten dies nicht ändern. Simulierte Responses-Anfragen bestätigten `service_tier: auto`. Das Backend liest seine Dienstpriorität unabhängig aus der Umgebung.
- **130 / 130 Node-Prüfungen**, **30 / 30 Playwright-Prüfungen** und die Produktionsoberfläche bestanden. Protokolle: `.cache/provider-only-node-tests.log`, `.cache/provider-only-browser-tests.log` und `.cache/provider-only-build.log`.
- Browserprüfungen bestätigten genau vier Auswahlfelder, unveränderbare Parameter, Speicheranfragen ausschließlich mit Anbietern, wirkungsloses Abbrechen, Entwurfserhalt bei Fehlern, Auswahl nach Neuladen und ausdrücklich zu speichernde Standardwerte. Desktop- und schmale Darstellung sowie Fokus wurden weiterhin geprüft.
- Es gab keine echten kostenpflichtigen Modellaufrufe oder physischen Mikrofonprüfungen. Änderungen lagen nur in diesem Projekt; die vorhandene `.env` blieb unverändert.

## Deutsche Oberfläche und Vorbereitung der GitHub-Veröffentlichung

Ergänzende Prüfung vom 27.09.2026:

- Startseite und Vorbereitung verwenden **Vor- und Nachbereitung**. Die drei Vorschläge heißen **Alle sieben Wochentage lernen**, **Weitere Farben ergänzen** und **Stunde zusammenfassen**; auch ihre vorbereiteten Nachrichten sind auf Deutsch. Die Eingabe heißt **Deine Nachricht**. Die Sprachauswahl zeigt **Automatisch**, **Chinesisch**, **Englisch** und **Deutsch**. Markenanzeige und Parameterbeschriftungen sind ebenfalls auf Deutsch.
- Alle vier versionierten Markdown-Dateien wurden vollständig ins Deutsche übersetzt. Frühere Ergebnisse bleiben als historische Aufzeichnungen erkennbar. `.env.example` enthält deutsche Kommentare und beschreibt korrekt, dass lokale Schlüsselwerte ignoriert werden. Die vorhandene `.env` und Nutzerdaten wurden nicht verändert.
- Die Prüfung aller festen Texte in `src`, `server`, `shared` und aller versionierten Markdown-Dateien fand keine chinesischen Schriftzeichen. Chinesische Testnachrichten bleiben bewusst in den Tests erhalten; Chat und Spracheingabe dürfen weiterhin Chinesisch enthalten.
- **130 / 130 Node-Prüfungen**, **30 / 30 Playwright-Prüfungen** und die abschließende Produktionsoberfläche bestanden. Die Windows-Stoppprüfung verwendet nun deutsche Statusmeldungen. Die drei PowerShell-Dateien wurden zusätzlich auf Syntaxfehler geprüft. Protokolle: `.cache/german-ui-node-tests.log`, `.cache/german-ui-browser-tests.log` und `.cache/german-ui-build.log`.
- Startseite, Einstellungen und Vorbereitung wurden zusätzlich bei 1280×620 und 390×844 mit einem simulierten lokalen Dienst geprüft. Die Sprachauswahl behält `zh`; alle drei Vorschläge füllen deutsche Nachrichten ein. Die Vorbereitung hat keinen horizontalen Überlauf. Desktop- und schmale Bilder wurden visuell geprüft und bleiben unter `.cache/german-*.png`.
- `.gitignore` wurde um Zugangsdaten-Dateien, Dienstkonto-Dateien, Exporte und weitere SQLite-/Datenbank-Begleitdateien ergänzt. Praktische Ausschlussprüfungen bestätigten, dass `.env`, Datenbanken, Schlüssel, Abhängigkeiten, Cache, Oberfläche und Prüfberichte nicht versioniert werden. `.env.example` bleibt versioniert und enthält leere Schlüsselwerte.
- Der zur Veröffentlichung vorgesehene Git-Index umfasst 95 Projektdateien. Die Schlüsselprüfung verglich auch vorhandene Prozessschlüssel mit dem Index; echte Schlüssel wurden nicht gefunden. Alle Musterfunde waren ausdrücklich geprüfte synthetische Werte in Testdateien. `git diff --cached --check` bestand.
- Das Ziel `wanzhikid123/KI-Englischlehrerin` wurde als leeres öffentliches GitHub-Repository bestätigt. Git wurde ausschließlich im Projektverzeichnis mit Zweig `main` und diesem Ziel eingerichtet. Die Quellcodeveröffentlichung stellt keinen öffentlichen Anwendungsdienst bereit.
- In dieser Runde wurden keine echten Modelle aufgerufen und keine physischen Mikrofone, Kinderstunden oder Safari/iPad geprüft. Die Prüfung und alle temporären Dateien blieben in `KI-Englischlehrerin`; beide Ursprungsprojekte wurden nicht geöffnet oder verändert.
