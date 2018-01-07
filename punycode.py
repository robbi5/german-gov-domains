#!/usr/bin/python3
# -*- coding:utf-8 -*-

import sys

for line in sys.stdin:
	domaininfos = line.strip().split(",")

	try:
		domain = domaininfos[0]
		encodeddomain = domain.encode("idna")
		domaininfos[0] = encodeddomain.decode("UTF-8")
		print(",".join(domaininfos))
	except UnicodeError:
		# after fail just print it
		print(line)

