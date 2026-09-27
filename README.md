# KI-Englischlehrerin

Eine eigenständige lokale Englischlern-App mit deutscher Benutzeroberfläche. Sie unterstützt Live-Gespräche über OpenAI oder Gemini, PCM-Audioverarbeitung und eine eigene Unterrichtssteuerung. Für vier Aufgabenbereiche lassen sich die Anbieter unabhängig auswählen. Die App bietet Themen, Vorbereitungsgespräche, Unterrichtspläne, Rückmeldungen zu Antworten, Lernaufzeichnungen und den direkten Start gespeicherter Unterrichtspläne.

## Starten und beenden

Voraussetzung ist Node.js ab Version 24. Für die bestehende Browserprüfung wird Chrome verwendet. Ein Doppelklick auf `Start-KI-Englischlehrerin.cmd` startet die App; beim ersten Start werden die Abhängigkeiten installiert und die Oberfläche erstellt. Die Standardadresse ist <http://127.0.0.1:3212>; der Dienst ist nur auf dem eigenen Rechner erreichbar.

`Stop-KI-Englischlehrerin.cmd` speichert den Zustand und beendet den Dienst dieses Projekts. `Restart-KI-Englischlehrerin.cmd` startet ihn neu. Das Schließen des Browsers beendet den Hintergrunddienst nicht. Die Skripte lesen Port und Datenverzeichnis aus `.env` und übernehmen vorhandene Windows-Benutzer- oder Systemvariablen für die API-Schlüssel.

Alternativ im Terminal:

```powershell
npm.cmd ci
npm.cmd run build
npm.cmd start
```

Beim Terminalstart werden die Umgebungsvariablen des aktuellen Prozesses und die Einstellungen aus `.env` verwendet. Nach dem Anlegen neuer Windows-Umgebungsvariablen muss in der Regel ein neues Terminal geöffnet werden. Mit Strg+C lässt sich der Dienst im Terminal beenden.

## Sprache der Oberfläche

Navigation, Überschriften, Schaltflächen, Beschriftungen und Sprachauswahl sind auf Deutsch. Auch die Markdown-Dokumentation des Projekts ist auf Deutsch. Englische Lernwörter sowie Modellnamen und technische Bezeichner bleiben unverändert. Im Vorbereitungsgespräch darf auf Chinesisch geschrieben oder gesprochen werden; Nachrichten und erkannte Sprache werden nicht wegen der Oberflächensprache übersetzt. Die Sprachauswahl bietet **Automatisch**, **Chinesisch**, **Englisch** und **Deutsch**.

## Vier Aufgabenbereiche konfigurieren

Das Zahnrad oben rechts öffnet **Einstellungen & Verbindung**. Jeder Bereich hat genau ein bearbeitbares Feld **Anbieter**. Modell, Live-Stimme, Denkintensität von Backend und Vorbereitungsassistent sowie die jeweils relevante OpenAI-Dienstpriorität werden aus der Umgebung angezeigt und können hier nicht geändert werden.

Erst **Speichern** übernimmt alle vier Anbieter gemeinsam, ohne Neustart. Schließen oder **Abbrechen** verwirft ungespeicherte Änderungen. **Standardwerte** setzt die Auswahl auf die Vorgaben beim Start zurück; auch diese Auswahl muss gespeichert werden. `data/model-settings.json` speichert ausschließlich die Anbieter und erhält die Auswahl über Neuladen und Neustarts hinweg. Aus älteren Einstellungsdateien werden nur Anbieter übernommen; frühere Überschreibungen von Modell, Stimme, Denkintensität und Dienstpriorität werden ignoriert. Beim nächsten Speichern wird das neue Format verwendet.

Während einer laufenden Stunde, Vorbereitung, Unterrichtsplanerstellung oder Transkription fordert das Speichern zum Warten auf. Ein laufender Aufruf verwendet weiterhin seine bisherige Konfiguration. Hat ein anderes Fenster bereits gespeichert, muss das ältere Einstellungsfenster erneut geöffnet werden.

Modell, Stimme, Denkintensität und Dienstpriorität des Backends stammen immer aus der Umgebung: Prozess- bzw. Systemvariablen haben Vorrang vor `.env`, danach folgen Programmvorgaben. Änderungen an `.env` erfordern einen Neustart; gespeicherte Anbieter halten keine alten Modellparameter fest. Ohne gespeicherte Auswahl gelten die Anbieter aus der Umgebung. Groß- und Kleinschreibung wird bei Anbietern akzeptiert. Ein automatischer Wechsel zu einem anderen Anbieter findet nicht statt.

| Umgebungsvariable | Anbieter | Aufgabe | Standardkonfiguration |
| --- | --- | --- | --- |
| `LIVE_MODEL_PROVIDER` | `openai` / `gemini` | Live-Sprache und Live-Untertitel | OpenAI `gpt-live-1` / `marin` |
| `BACKEND_MODEL_PROVIDER` | `openai` / `deepseek` | Unterrichtsplanung, Antwortbewertung, Tafelsteuerung und Zusammenfassung | OpenAI `gpt-6-luna` / low / fast |
| `TRANSCRIPTION_MODEL_PROVIDER` | `openai` / `gemini` | Aufnahmen im Vorbereitungsgespräch in Text umwandeln | OpenAI `gpt-transcribe` |
| `TEACHER_MODEL_PROVIDER` | `openai` / `gemini` / `deepseek` | Gespräche, Themenpflege und Unterrichtspläne | OpenAI `gpt-6-luna` / high / auto |

Gemini Live verwendet `GEMINI_LIVE_MODEL=gemini-3.8-live` und `GEMINI_VOICE=Kore`; OpenAI verwendet `GPT_LIVE_MODEL` und `GPT_VOICE`. Die Modellvariablen der anderen drei Bereiche sind in `.env.example` beschrieben und lassen sich unabhängig in `.env` konfigurieren.

Jeder Bereich liest ausschließlich den zugehörigen `OPENAI_API_KEY`, `GEMINI_API_KEY` oder `DEEPSEEK_API_KEY` aus den Umgebungsvariablen des Prozesses. Die Startskripte übernehmen Windows-Benutzer- und Systemvariablen; auch vorhandene Variablen namens `openai_api_key` werden unterstützt. **API-Schlüssel aus einer lokalen `.env` werden nicht verwendet.** Es gibt kein Eingabefeld für Schlüssel und keinen Ersatz durch Schlüssel anderer Anbieter. Schlüssel gelangen nicht in Oberfläche, Protokolle, Datenbank oder Einstellungsdatei. Die Einstellungen zeigen nur, ob ein Schlüssel geladen wurde. Fehlende Schlüssel führen zu einer verständlichen Fehlermeldung; lokale Aufzeichnungen bleiben lesbar. Nach dem Anlegen eines Systemschlüssels muss der Dienst neu gestartet werden.

Nur das OpenAI-Backend liest `OPENAI_BACKEND_SERVICE_TIER` (`auto` / `fast`) und zeigt diesen Wert in den Einstellungen an. **Gespräche & Unterrichtsplan** verwendet bei OpenAI immer `auto`; `OPENAI_TEACHER_SERVICE_TIER` und früher gespeicherte Werte werden ignoriert. Dieser feste Wert wird im Einstellungsfenster nicht angezeigt. Modellzugriff, Denkstufen und Berechtigung für `fast` hängen vom Anbieterkonto ab; `fast` kann zusätzliche Kosten verursachen.

Der Transkriptionsanbieter steuert nur Aufnahmen bei der Vorbereitung, nicht die Erkennung oder Untertitel des Live-Gesprächs.

## API-Anbindung

- OpenAI Live verwendet WebRTC-Audio mit einer serverseitigen Steuerverbindung. Gemini Live verwendet SDK-WebSockets auf dem Server und lokale WebSockets mit PCM-Audio. Abtastratenumwandlung, Leeren der Wiedergabe, Unterbrechungen und Abschlussbestätigung bleiben erhalten.
- OpenAI und DeepSeek verwenden jeweils ihren offiziellen `/responses`-Endpunkt. Der vollständige Verlauf der Werkzeugaufrufe bleibt für Folgerunden im Speicher. Dazu gehören verschlüsselter OpenAI-Denkkontext und DeepSeek-Denkinhalte; diese internen Inhalte werden nicht dauerhaft gespeichert.
- Gemini-Vorbereitung verwendet natives `generateContent`, übersetzt Werkzeugdefinitionen und Werkzeugantworten und gibt vollständige Modellteile sowie Denksignaturen zurück.
- OpenAI-Transkription verwendet `/audio/transcriptions`. Gemini verwendet die native Interactions API mit `gemini-3.5-transcribe`, eingebettetem Audio und `store:false`.

Offizielle Dokumentation zu den API-Adaptern: [OpenAI Fast mode](https://developers.openai.com/api/docs/guides/fast-mode), [DeepSeek Responses](https://api-docs.deepseek.com/guides/responses_api/), [Gemini-Werkzeugaufrufe](https://ai.google.dev/gemini-api/docs/generate-content/function-calling) und [Gemini-Denkparameter](https://ai.google.dev/gemini-api/docs/thinking). Die Adapter senden OpenAI-Parameter wie `service_tier` oder verschlüsselten Denkkontext nicht an Gemini oder DeepSeek.

Weitere Referenzen: [OpenAI-Denkparameter](https://developers.openai.com/api/docs/guides/reasoning), [GPT-Live-Sitzungen und Stimmen](https://developers.openai.com/api/docs/guides/live-conversations) und [Gemini-Live-Funktionen](https://ai.google.dev/gemini-api/docs/live-api/capabilities). Die Einstellungen zeigen die Umgebungskonfiguration; Zugriff und Parameterunterstützung bestimmt der jeweilige Anbieter.

## Wartung und Prüfung

```powershell
npm.cmd test
npm.cmd run build
npm.cmd run test:browser
npm.cmd run check:api
```

Die ersten drei Befehle rufen keine echten Modelle auf. Die Browserprüfungen enthalten simulierte OpenAI-Verbindungen, echte Browser-AudioWorklets und lokale PCM-Übertragung. `check:api` prüft lediglich den Zugriff auf die ausgewählten Modelle, erzeugt keine Inhalte und sendet keine Lernaufzeichnungen. Es bestätigt weder Sprachqualität noch Werkzeugqualität oder die Unterstützung bestimmter Kombinationen aus Dienstpriorität und Denkstufe.

Das optionale `node scripts/smoke-text.js` sendet synthetische Werkzeugtests an echte Backend- und Vorbereitungsmodelle; dabei können Kosten entstehen. `--all` prüft alle Textanbieter mit eingerichtetem Schlüssel und kennzeichnet fehlende Schlüssel als übersprungen. Echte Lernaufzeichnungen werden nicht gelesen, Denkinhalte nicht ausgegeben. Ergebnisse und Grenzen stehen in `VALIDATION.md`.

`REQUIREMENTS.md` beschreibt Anforderungen, `VALIDATION.md` dokumentiert Prüfungen und Grenzen, `THIRD_PARTY_NOTICES.md` enthält Lizenzhinweise. Abhängigkeiten und Oberfläche werden im Projektverzeichnis erstellt.

## GitHub-Veröffentlichung

Der Quellcode wird unter [KI-Englischlehrerin auf GitHub](https://github.com/wanzhikid123/KI-Englischlehrerin) veröffentlicht. `.gitignore` schließt API-Schlüssel, lokale Konfiguration, Daten, SQLite-Begleitdateien, Abhängigkeiten, erzeugte Oberfläche, Protokolle, Testberichte, Sicherungen und Exporte aus. `.env.example` enthält nur leere Schlüsselwerte und bleibt versioniert. Eine Veröffentlichung des Quellcodes verändert nicht den lokalen Betrieb; die App wird dadurch nicht als öffentlicher Webdienst bereitgestellt.
