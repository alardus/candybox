###
# Setting up RPi params without running raspi-config

# Information available at project homepage:
# http://www.candyboxrouter.org

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

config = '/boot/config.txt'
freq = 'arm_freq=900 \n'

with open(config, 'r') as fl:
	lines = fl.readlines()

with open(config, 'w') as fl:
	for line in lines:
		if not "arm_freq" in line:
			fl.write(line)
		else:
			fl.write(freq)
