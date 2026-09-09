import sys,xbmc,xbmcvfs,subprocess,xbmcgui,os,time,easy
def main():
	try:
		command = sys.argv[1]
	except IndexError:
		return
	if command == 'restart':
		easy.restart()
	elif command == 'shutdown':
		easy.shutdown()
	elif command == 'labber':
		easy.labber()
	elif command == 'browser':
		easy.browser()
	elif command == 'ftp':
		easy.ftps()
	elif command == 'apps':
		easy.apps()
	elif command == 'playfavo':
		easy.play_favorite(0)
	elif command == 'adb':
		easy.adb()
	elif command == 'wifi':
		easy.wifi()
	elif command == 'yut':
		easy.yut()
	elif command == 'inf':
		easy.yut()
	elif command == 'trailer':
		easy.toggle_auto_trailer()
	elif command == 'apk':
		easy.apk()
	elif command == 'home':
		easy.home()
	elif command == 'blue':
		easy.blue()
	elif command == 'kids':
		easy.kids()
	elif command == 'xmenu':
		easy.xmenu()
	elif command == 'paste':
		easy.liste()
	elif command == 'pupdate':
		easy.pupdate()
	elif command == 'tcopy':
		easy.tcopy()
	elif command == 'tclose':
		easy.tclose()
	elif command == 'dns':
		easy.dns_check()
	elif command == 'tcloud':
		easy.tcloud()
	elif command == 'clipboard':
		easy.liste1()
	elif command == 'uploads':
		easy.show_manager()
	elif command == 'mic':
		easy.amaz()
	elif command == 'liste':
		easy.liste()
	elif command == 'liste1':
		easy.liste1()
	elif command == 'backup':
		easy.xbackup()
	elif command == 'xclipboard':
		easy.xclipboard()
	elif command == 'install':
		easy.xinstall()
	elif command == 'stream':
		easy.video()
	elif command == 'fm':
		easy.filemanager()
	elif command == 'pyth':
		easy.pyth()
	elif command == 'npdl':
		easy.np_install()
	elif command == 'npsearch':
		easy.np_search()
	elif command == 'npplay':
		easy.np_play()
	else:
		raise ValueError('Unknown command: %r' % command)
	return
if __name__ == '__main__':
	main()