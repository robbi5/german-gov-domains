.DEFAULT_GOAL := all

data/source/bundde.csv:
	ruby bundde-behoerden-scraper.rb | sort -d -f -t',' -k1,1 > $@

data/domains.csv: data/source/bundde.csv data/source/ifg-bmvi.csv data/source/ifg-dwd.csv data/source/ifg-bmas.csv data/source/ifg-bva.csv data/source/bmf.csv
	echo Domain Name,Agency > $@
	sed '1d' data/source/overrides.csv > data/source/overrides.csv.tmp
	grep -h -v '^#' $+ | sort -d -f -t',' -k1,1 --unique data/source/overrides.csv.tmp - >> $@
	rm data/source/overrides.csv.tmp

clean:
	rm data/source/bundde.csv

all: data/domains.csv