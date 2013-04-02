import time, os
date = time.asctime( time.localtime(time.time()) )
link = raw_input('Link to file at Disk: ')
name = 'Download'
html = 'index.html'

with open(html, 'r') as fl:
	lines = fl.readlines()

with open(html, 'w') as fl:
	for line in lines:
		if not '<!--place here-->' in line: 
			fl.write(line)
		else:
			fl.write('<!--place here-->' + '\n')
			fl.write(date + ' ' + '<a href=' + link + '>' + name + '</a>' + '<br>' + '\n')

os.system('curl -T index.html ftp://u364630.ftp.masterhost.ru/bearouter.org/www/beta/ --user u364630:unspor92kb')