# Easy-TV – Technische Funktions- und Modulübersicht

Easy-TV ist ein eigenständiger XBMC-Fork, der eine native Android-Java-Schicht mit einer plattformübergreifenden Python/Core-Architektur verbindet, um Medien-Setups auf Android (insbesondere Amazon Fire TV Sticks) und Windows zu optimieren.

---

### 1. App-Lebenszyklus & Wartung
* **System-Reset & Cache-Bereinigung:** Sauberes Beenden, Cache-Clearing (`ClearData.java`) und automatisierter Neustart der gesamten Umgebung (`RestartActivity.java`).
* **Autostart & Intents:** Initialisierung beim Systemstart (`Boot.java`) sowie Event-Handling über Broadcasts (`XBMCBroadcastReceiver.java`).
* **OTA-Updates:** Integriertes Update-System zur Versionsprüfung, zum Herunterladen und zur Installation neuer Easy-TV APK-Builds (`UpdateActivity.java`).

### 2. Natives Browsing mit Werbeblocker
* **Integrierter Web-Viewer:** Browser-Komponente mit aktiver Adblock-Filterung für externe Streaming- und Download-Portale (`Adwebview.java`, `WebActivity.java`, `WebViewUtils.java`).
* **Verlauf & Favoriten:** Lokale Speicherung besuchter Seiten (`HistoryItem.java`, `HistoryList.java`) und Lesezeichen (`FavoriteItem.java`, `FavoritesList.java`).

### 3. Integrierter Downloader, Packer & Zipper
* **Multithread-Downloader:** Eigenständiger Downloader für Remote-Assets, APKs und Bundle-Archive inklusive Download-Historie (`FileHelper.java`, `XBMCFile.java`, `DownloadList.java`).
* **Archivierung & Dateisystem:** Natives Packen (ZIP), Entpacken und Organisieren großer Dateiarchive im lokalen Speicher (`/sdcard/Download`, App-Speicher).

### 4. Smart-TV- & Fire TV Stick-Tools
* **Virtuelle Maussteuerung (`CursorLayout.java`, `over.java`):** Systemweites Mauszeiger-Overlay zur vollständigen Steuerung über Standard-Fernbedienungen (D-Pad/Remote) für Touch- und Web-Inhalte.
* **Sprachsteuerung & Voice-Assistenz:** Anbindung an die Amazon Fire TV Remote (Speech-to-Text) zur Navigation, Suche und Texteingabe.

---

### 5. Plattform- & Systemverwaltung (Python / Core-Layer)
* **Plattformerkennung:** 
  * Erkennt dynamisch das Host-System (**Windows** vs. **Android**).
  * Differenziert unter Android gezielt die CPU-Architektur (**android32** oder **android64**).
  * Initialisiert plattformspezifische Pfade für App-Daten, Downloads und Zwischenspeicher.
* **Zentrale Datenbank (`easytv.db`):** SQLite-Verwaltung für Zwischenablage (Pastelist), Favoriten, Uploads und Browser-Logs.
* **OS-Integration:**
  * Öffnet Systemeinstellungen (WLAN, Bluetooth, Apps, Entwickleroptionen/ADB) über Android-Intents bzw. Windows `ms-settings:`-URIs.
  * Unterstützt NewPipe-Aktivitäten zur Video-Weitergabe unter Android.
* **Netzwerk-Tools:** Integrierte DNS-Prüfung und -Umschaltung (z. B. Cloudflare `1.1.1.1` oder Google `8.8.8.8`) unter Windows via Batch und `netsh`.

---

### 6. Backup-, Restore- & Bundle-Management
* **Sicherungsmodi:**
  * **Skin Backup:** Sichert Benutzeroberfläche, Shortcuts und Favoriten (`skinshortcuts`, `favourites.xml`).
  * **Settings Backup:** Sichert gezielt `guisettings.xml`, `sources.xml` und `favourites.xml`.
  * **Full Backup:** Bereinigt temporäre Ordner (`packages/`, `Thumbnails/`) und packt das Home-Verzeichnis mit grafischer Fortschrittsanzeige als ZIP.
* **Plattformkompatibilität (`_is_excluded`):** Filtert binäre, systemspezifische Addons (`inputstream.adaptive`, CDM/Widevine, Joystick-Treiber) sowie Caches automatisch heraus, damit erstellte Bundles plattformübergreifend kompatibel bleiben.
* **Bundle-Installer (`xinstall`):**
  * **Neu Anfang:** Werkseitiger Reset mit Installation eines sauberen Basis-Bundles.
  * **Online / Lokal:** Download oder Offline-Installation von ZIP-Archiven unter Erhalt der Quellen und Favoriten.
* **Community-Cloud (`easy-tv.org` API):**
  * Filtert Bundles nach Architektur (Windows64, Android32, Android64).
  * Community-Katalog mit Sterne-Bewertungen, Kommentaren und Download-Zählern.
  * Upload und Pflege eigener Bundles.
  * Sichere Authentifizierung über Windows DPAPI bzw. Android `shared_prefs`.

---

### 7. Externe Dienste, Cloud & Messaging
* **Filebin-Upload & Manager:** Automatisches Packen und Hochladen von Bundles via HTTP-PUT auf filebin.net (7 Tage Vorhaltezeit) mit Restzeitanzeige, Schreibschutz und Löschfunktion.
* **Telegram Cloud (`tcloud`):** Bot-Integration zum direkten Streamen und Abrufen von Medien (Videos, Musik, Dokumente, Links) aus Telegram-Chats in Easy-TV.
* **Integrierte Zwischenablage (Pastelist):** SQLite-basierte Text- und URL-Zwischenablage, direkt über das Easy-TV OSD-Keyboard via JSON-RPC ansteuerbar.
* **Briefkasten & Messaging:** Interner Austausch von Download-Links und Nachrichten mit registrierten Forenbenutzern, passwortgeschütztes Postfach und Kontaktverwaltung (`easytv_friends.json`).


