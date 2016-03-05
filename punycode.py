#!/usr/bin/python
# -*- coding:utf-8 -*-

import sys
reload(sys)  
sys.setdefaultencoding('utf8')

infile = open(sys.argv[1])

for line in infile:
	try:
		erg=line.decode('utf-8') # check if ascii or utf8.. it will fail if it is ascii
		domain=unicode(line.strip())
		print(domain.encode("idna"))
	except UnicodeError:
		print line.strip()

infile.close()
