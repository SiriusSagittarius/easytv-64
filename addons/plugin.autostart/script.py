import sys
import xbmcgui
import easy


def main():
    if len(sys.argv) < 2:
        return
    command = sys.argv[1]
    param = sys.argv[2] if len(sys.argv) > 2 else ""

    if command == 'search':
        easy.yt_suche_start()
    elif command == 'paste':
        easy.Cliste()
    elif command == 'copy':
        easy.tcopy()
    elif command == 'save':
        easy.ytp_save_current_search()
    elif command == 'load':
        easy.ytp_load_saved_search()
    elif command == 'youtubedl':
        easy.dl_play()
    elif command == 'start':
        easy.ytp_show_list_dialog()
    elif command == 'play':
        easy.dl_play_video_via_ytdlp(param)
    elif command == 'favo':
        easy.web_favs_menu()
    elif command == 'live':
        easy.ytp_show_live_url(param)
    elif command == 'down':
        easy.ytp_download_video(param)
    elif command == 'dlvideo':
        from resources.lib import dl
        dl.dlvideo()
    elif command == 'dlaudio':
        from resources.lib import dl
        dl.dlaudio()
    elif command == 'delete':
        easy.delete()
    elif command == 'upload':
        easy.upload_menu()
    elif command == 'savetext':
        easy.savetext()
    elif command == 'tc':
        easy.tcloud()
    elif command == 'internet':
        easy.internet()
    elif command == 'post':
        easy.postfach()
    elif command == 'mail':
        easy.startup_mail_check()
    elif command == 'webfavs':
        easy.web_favs_menu()
    elif command == 'verlauf':
        easy.web_history_menu()
    elif command == 'browser':
        easy.browser()
    elif command == 'pw':
        easy.webview("https://humpfy.de/pinwand")
    elif command == 'webview':
        if param:
            easy.webview(param)
        else:
            easy.home()
    else:
        xbmcgui.Dialog().ok("Fehler", f"Unbekannter Befehl: {command}")


if __name__ == '__main__':
    main()