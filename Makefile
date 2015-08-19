.DEFAULT_GOAL := all

data/source/bundde.csv:
	ruby bundde-behoerden-scraper.rb | sort -d -f -t',' -k1,1 > $@

data/domains.csv: data/source/bundde.csv data/source/ifg-bmvi.csv data/source/ifg-dwd.csv data/source/ifg-bmas.csv
	echo Domain Name,Agency > $@
	grep -h -v '^#' $+ | sort -d -f -t',' -k1,1 --unique data/source/overrides.csv - >> $@

clean:
	rm data/source/bundde.csv

all: data/domains.csv