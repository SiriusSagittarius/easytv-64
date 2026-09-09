import sys
import urllib.parse
import xbmcgui, xbmc, easy
import xbmcplugin
import xbmcaddon

addon = xbmcaddon.Addon("plugin.autostart")


def router(paramstring):
    params = dict(urllib.parse.parse_qsl(paramstring))
    action = params.get('action')
    handle = int(sys.argv[1]) if len(sys.argv) > 1 else -1
    try:
        if action == 'favo':
            easy.web_favs_widget(handle)
        elif action == 'webfavs':
            easy.web_favs_widget(handle)
        elif action == 'video':
            url = params.get('url', '')
            if handle != -1:
                xbmcplugin.endOfDirectory(handle, succeeded=False)
            if url:
                easy.video(url)
            else:
                xbmc.log("[plugin.autostart] 'video' aufgerufen, aber keine URL übergeben", xbmc.LOGWARNING)
        elif action == 'webhistory':
            easy.web_history_widget(handle)
        elif action == 'item_options':
            if handle != -1:
                xbmcplugin.endOfDirectory(handle, succeeded=False)
            url = params.get('url', '')
            title = params.get('title', url)
            favicon = params.get('favicon', '')
            is_fav = params.get('is_fav', '0') == '1'
            show_item_options(url, title, favicon, is_fav)
        elif action == 'openweb':
            xbmcplugin.endOfDirectory(handle, succeeded=False)
            easy.webview(params.get('url', ''))
        elif action == 'post':
            xbmcplugin.endOfDirectory(handle, succeeded=False)
            easy.postfach()
        else:
            main_menu()
    except Exception as e:
        # Passiert z.B. wenn dieser Aufruf nicht als normale Directory-Listing-
        # Anfrage reingekommen ist (kein gueltiger CDirectoryProvider-Handle),
        # sondern als Script-/Play-Resolve-Aufruf (z.B. via RunScript/PlayMedia
        # aus dem Skin statt ActivateWindow/Container.Update). In dem Fall gibt
        # es keinen offenen Listing-Job fuer 'handle', addDirectoryItem/
        # endOfDirectory laufen dann ins Leere.
        xbmc.log(
            f"[plugin.autostart] router() Fehler bei action='{action}', handle={handle}: {e}",
            xbmc.LOGERROR
        )
        try:
            xbmcplugin.endOfDirectory(handle, succeeded=False)
        except Exception:
            pass


def show_item_options(url, title, favicon, is_fav):
    if not url:
        return
    dialog = xbmcgui.Dialog()
    options = [
        '[B][COLOR=lime]ÖFFNEN (WEBVIEW)[/COLOR][/B]',
        '[B][COLOR=cyan]IN EASY-TV ABSPIELEN[/COLOR][/B]',
        '[B][COLOR=yellow]IN ZWISCHENABLAGE KOPIEREN[/COLOR][/B]',
    ]
    if is_fav:
        options.append('[B][COLOR=orange]AUS FAVORITEN LÖSCHEN[/COLOR][/B]')
    else:
        options.append('[B][COLOR=orange]ZU FAVORITEN HINZUFÜGEN[/COLOR][/B]')
        options.append('[B][COLOR=red]AUS VERLAUF LÖSCHEN[/COLOR][/B]')

    sel = dialog.select(title or url, options)
    if sel == 0:
        easy.webview(url)
    elif sel == 1:
        easy.video(url)
    elif sel == 2:
        try:
            conn = easy._web_db_connect()
            conn.execute("INSERT OR IGNORE INTO clipboard (entry) VALUES (?)", (url,))
            conn.commit()
            conn.close()
            dialog.notification("Clipboard", "In Zwischenablage kopiert", xbmcgui.NOTIFICATION_INFO, 2500)
        except Exception as e:
            xbmc.log(f"Clipboard Fehler: {e}", xbmc.LOGERROR)
    elif sel == 3:
        if is_fav:
            easy.web_fav_remove(url)
        else:
            easy.web_fav_add(url, title, favicon)
        xbmc.executebuiltin("Container.Refresh")
    elif sel == 4 and not is_fav:
        easy.web_history_remove(url)
        xbmc.executebuiltin("Container.Refresh")


def main_menu():
    if len(sys.argv) <= 1:
        xbmcgui.Dialog().notification(
            "EASYTV",
            "Plugin ohne GUI-Kontext gestartet",
            xbmcgui.NOTIFICATION_WARNING
        )
        return
    handle = int(sys.argv[1])
    base_url = sys.argv[0]
    items = [
        {'label': 'WEB FAVORITEN', 'action': 'webfavs'},
        {'label': 'WEB VERLAUF', 'action': 'webhistory'},
    ]
    for item in items:
        li = xbmcgui.ListItem(label=item['label'])
        url_with_action = f"{base_url}?action={item['action']}"
        xbmcplugin.addDirectoryItem(handle, url_with_action, li, item.get('folder', True))
    xbmcplugin.endOfDirectory(handle)


if __name__ == '__main__':
    if sys.argv[0].startswith('plugin://'):
        paramstring = sys.argv[2][1:] if len(sys.argv) > 2 else ''
        router(paramstring)
    else:
        arg = sys.argv[1] if len(sys.argv) > 1 else ''
        if arg == 'mail':
            easy.startup_mail_check()