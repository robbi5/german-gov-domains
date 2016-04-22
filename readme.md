German Government Domains
=========================

An incomplete listing of german government domains (and the code for the scraper used to build the list).

You can **download the list [as a .csv file](https://raw.githubusercontent.com/robbi5/german-gov-domains/master/data/domains.csv)** or **view it with [github's pretty formatting](https://github.com/robbi5/german-gov-domains/blob/master/data/domains.csv)**.

We try to use the same format as the [US GSA](https://github.com/GSA/data) ([example](https://github.com/GSA/data/blob/e0de99db0e1367e304043e88dbd4da8f391774be/dotgov-domains/2016-01-19-full.csv)), so the CSV file has a header of `Domain Name,Domain Type,Agency,City,State` and currently contains government agencies and cities.

## Variants

If you only want a subset of the available data, variants filtered by `Domain Type` are provided:

* [`data/domains.csv`](data/domains.csv) contains everything
* [`data/domains.federal.csv`](data/domains.federal.csv) contains only government agencies (`Federal Agency`)
* [`data/domains.cities.csv`](data/domains.cities.csv) contains only cities (`City`)

## Why?

There currently isn't a publicly available directory of all the domain names registered by the german government and its agencies. Such a directory would be useful for people looking to get an aggregate view of government websites and how they are hosted. For example, [Ben Balter](http://ben.balter.com) has been doing some great work [analyzing](http://ben.balter.com/2015/05/11/third-analysis-of-federal-executive-dotgovs/) the [official set of US `.gov` domains](https://github.com/GSA/data/tree/gh-pages/dotgov-domains).

This is by no means an official or a complete list. It is intended to be a first step toward a better understanding of how the government is managing its official sites.


## What can I do with it?

* Plug the CSV into [18F/domain-scan](https://github.com/18F/domain-scan) to get more data (like HTTPS support) about the domains
* Check the IPv6 reachability
* Test if the sites are reachable even without the `www.` subdomain
* ...?


## How to update

The list is populated by scrapers and static files and merged by a makefile.
To run the process yourself, checkout this repository and run:

    bundle install
    make

After everything ran, you can look into `data/domains.csv`.

## Scrapers and Sources

* `bundde-behoerden-scraper.rb`: crawls an [official government agency list](http://www.bund.de/Content/DE/Behoerden/Suche/Formular.html?nn=4641514).
* `wikidata-cities.rb`: uses a [sparql query](https://query.wikidata.org) to get cities with their domains from [Wikidata](https://wikidata.org).
* `data/source/bmf.csv`: list from BMF, manually extracted from their [digital services page on bundesfinanzministerium.de](http://www.bundesfinanzministerium.de/Web/DE/Service/Digitale-Angebote/Digitale-Angebote.html)
* `data/source/ifg-bka.csv`: is a list from BKA, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-des-bundeskriminalamts/)
* `data/source/ifg-bmas.csv`: is a list from BMAS, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-in-maschinenlesbarer-form-1/)
* `data/source/ifg-bmvi.csv`: is a list from BMVI, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-in-maschinenlesbarer-form/)
* `data/source/ifg-bva.csv`: is a list from Bva, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-in-maschinenlesbarer-form-6/)
* `data/source/ifg-dwd.csv`: is a list from DWD, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-in-maschinenlesbarer-form-2/)
* `data/source/overrides.csv`: manually curated list of domains for which the scraper returns a wrong agency name

## Contributing

I'd love to have some help with this! Please feel free to [create an issue](https://github.com/robbi5/german-gov-domains/issues) or [submit a pull request](https://github.com/robbi5/german-gov-domains/pulls) if you notice something that can be better. Specifically, suggesting additional pages we can scrape and domains that are either not found or have incorrect organization names associated with them would be very helpful.

## Ideas

* scrape even more domains
  * scrape news articles on already known government sites
  * use the list of projects using the [Government Site Builder](https://www.bva.bund.de/DE/Organisation/Abteilungen/Abteilung_BIT/Leistungen/IT_Produkte/GSB/Referenzen/Alle/node.html)
  * use a wikidata query to get the website property of agencies listed in wikipedia [category](https://de.wikipedia.org/wiki/Kategorie:Bundesbeh%C3%B6rde_(Deutschland)) [pages](https://de.wikipedia.org/wiki/Kategorie:Beh%C3%B6rde_(Deutschland))
* manual collection
  * try to get some domains with an [freedom of information request](https://fragdenstaat.de)
  * look for domains in [minor interpellations](https://kleineanfragen.de)

## Thanks

Thanks to [@esonderegger](https://github.com/esonderegger) for the [dotmil domains project](https://github.com/esonderegger/dotmil-domains) that served as an template for this repo.