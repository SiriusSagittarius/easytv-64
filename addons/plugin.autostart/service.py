import sqlite3, xbmcgui, xbmcvfs, xbmc, json, os, easy, sys, xbmcaddon, time, xbmcplugin

IS_AND = xbmc.getCondVisibility("system.platform.android")



def load_and_display(db_path, table, fields, cache_folder, default_title="Kein Titel"):
    handle = int(sys.argv[1])
    if not os.path.exists(db_path):
        xbmc.log(f"DB nicht gefunden: {db_path}", xbmc.LOGERROR)
        xbmcplugin.endOfDirectory(handle)
        return
    with sqlite3.connect(db_path) as conn:
        conn.row_factory = sqlite3.Row
        cur = conn.cursor()
        cur.execute(f"SELECT {fields['title']}, {fields['url']}, {fields['thumbnail']} FROM {table}")
        rows = cur.fetchall()
    for row in rows:
        title = row[fields['title']] or default_title
        url = row[fields['url']] or ""
        thumbnail = row[fields['thumbnail']] or ""
        item = xbmcgui.ListItem(label=title)
        item.setArt({"thumb": thumbnail, "icon": thumbnail})
        xbmcplugin.addDirectoryItem(
            handle=handle,
            url=url,
            listitem=item,
            isFolder=False
        )
    xbmcplugin.setContent(handle, "videos")
    xbmcplugin.endOfDirectory(handle)


def delete_expired_uploads():
    addon = xbmcaddon.Addon("plugin.autostart")
    now = time.time()
    alive = []
    for i in range(1, 11):
        raw = addon.getSetting(f"upload.slot{i}")
        if raw:
            try:
                entry = json.loads(raw)
                exp = time.mktime(time.strptime(entry["expires"], "%d.%m.%Y %H:%M:%S"))
                if exp > now:
                    alive.append(entry)
            except:
                pass
    alive.sort(key=lambda x: time.mktime(time.strptime(x["expires"], "%d.%m.%Y %H:%M:%S")))
    for idx, entry in enumerate(alive, start=1):
        addon.setSetting(f"upload.slot{idx}", json.dumps(entry))
    for idx in range(len(alive) + 1, 11):
        addon.setSetting(f"upload.slot{idx}", "")


def run_youtube():
    if IS_AND:
        x1 = "/data/data/app.easytv.org/databases/youtube.db"
    else:
        x1 = xbmcvfs.translatePath("special://xbmc/system/library/youtube.db")
    load_and_display(
        db_path=x1,
        table="YTSUCHE",
        fields={"title": "title", "url": "url", "thumbnail": "thumbnail"},
        cache_folder="plugin.easy.youtube"
    )


def run_favorites():
    if IS_AND:
        x1 = "/data/data/app.easytv.org/databases/easytv.db"
        load_and_display(
            db_path=x1,
            table="favorites",
            fields={"title": "titel", "url": "url", "thumbnail": "favicon"},
            cache_folder="plugin.video.easyfavorites"
        )
    else:
        pass


# ------------------------------------------------------------------
# Post-Check beim EasyTV-Start.
# Erst warten, bis die Oberflaeche wirklich steht - waehrend des
# Startvorgangs (Splash/Skin laedt) geht ein Dialog sonst unter oder
# blockiert. startup_mail_check() ist zusaetzlich per Window-Property
# gegen Mehrfachlauf gesichert, ein Aufruf aus script.py/default.py
# stoert also nicht.
# ------------------------------------------------------------------
def _wait_for_gui(timeout=60):
    monitor = xbmc.Monitor()
    for _ in range(timeout):
        if monitor.abortRequested():
            return False
        if xbmcgui.getCurrentWindowId() == 10000:   # Home
            return True
        if monitor.waitForAbort(1):
            return False
    return False


if _wait_for_gui():
    try:
        easy.startup_mail_check()
    except Exception as e:
        xbmc.log(f"[EASY-TV] Post-Check fehlgeschlagen: {e}", xbmc.LOGERROR)