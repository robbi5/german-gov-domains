#!/usr/bin/python
# -*- coding:utf-8 -*-

import sys
reload(sys)  
sys.setdefaultencoding('utf8')

for line in sys.stdin:
	domaininfos=line.strip().split(",")

	try:
		erg=domaininfos[0].decode('utf-8') # check if ascii or utf8.. it will fail if it is ascii
		domain=unicode(domaininfos[0])
		encodeddomain=domain.encode("idna")
		domaininfos[0]=encodeddomain
		print ",".join(domaininfos)
	except UnicodeError:
		# after fail just print it 
		print line

