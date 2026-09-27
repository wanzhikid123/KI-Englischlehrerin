# Emoji-Grafiken und Daten

- **Twemoji**: Grafiken von Twitter, Inc. und weiteren Mitwirkenden, siehe [Projekt](https://github.com/jdecked/twemoji). Die Grafiken stehen unter [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) und werden unverändert als lokale SVG-Dateien ausgeliefert. Das installierte Paket `@twemoji/svg@15.0.0` enthält 3.720 Dateien. Paketierung und Optimierung stammen von Samuel Kopp und stehen unter MIT; die Lizenz liegt in `node_modules/@twemoji/svg/license`.
- **Emojibase-Daten**: Von Miles Johnson und weiteren Mitwirkenden, siehe [Projekt](https://github.com/milesj/emojibase) und [Datensätze](https://emojibase.dev/docs/datasets/). Lizenz: MIT, enthalten in `node_modules/emojibase-data/LICENSE`. Der lokale Server verwendet englische und deutsche Namen aus `emojibase-data@17.0.0`. Angeboten werden nur Einträge mit einer lokal verfügbaren SVG-Datei.

Emoji werden vom lokalen Dienst unter `/assets/emoji/` ausgeliefert. Der Browser ruft dafür kein externes Emoji-CDN auf. `npm ci` stellt die in `package-lock.json` festgelegten Abhängigkeiten wieder her.
