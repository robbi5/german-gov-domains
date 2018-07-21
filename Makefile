.DEFAULT_GOAL := all
.PHONY : all
.PHONY : clean
.PHONY : clean-sources

HEADER = Domain Name,Domain Type,Agency,City,State

FEDERAL_SOURCES = \
	data/source/bundde.csv \
	data/source/reverse-dns.csv \
	data/source/ifg-bmvi.csv \
	data/source/ifg-dwd.csv \
	data/source/ifg-bka.csv \
	data/source/ifg-bmas.csv \
	data/source/ifg-bt.csv \
	data/source/ifg-bva.csv \
	data/source/bmf.csv

data/source/bundde.csv:
	ruby bundde-behoerden-scraper.rb | sort -d -f -t',' -k1,1 > $@

data/source/wikidata.csv:
	ruby wikidata-cities.rb | sort -d -f -t',' -k1,1 -u > $@

data/domains.csv: data/domains.federal.csv data/domains.cities.csv
	echo ${HEADER} > $@
	tail -q -n +2 $+ | sed '/^$$/d' >> $@

data/domains.federal.csv: ${FEDERAL_SOURCES}
	echo ${HEADER} > $@
	LC_ALL=C sed '1d' data/source/overrides.csv > data/source/overrides.csv.tmp
	grep -h -v '^#' $+ | LC_ALL=C sort -d -f -t',' -k1,1 --unique data/source/overrides.csv.tmp - | python3 punycode.py | sed 's/,/,Federal Agency,/; s/$$/,,/' >> $@
	rm data/source/overrides.csv.tmp

data/domains.cities.csv: data/source/wikidata.csv
	echo ${HEADER} > $@
	grep -h -v '^#' $+ | python3 punycode.py | sed 's/,/,City,Non-Federal Agency,/' >> $@

clean-sources:
	rm -f data/source/bundde.csv
	rm -f data/source/wikidata.csv

clean: clean-sources
	rm -f data/domains*

all: data/domains.csv
