German Government Domains
=========================

An incomplete listing of german government domains (and the code for the scraper used to build the list).

You can download the list [as a .csv file](https://raw.githubusercontent.com/robbi5/german-gov-domains/master/data/domains.csv) or **view it with [github's pretty formatting](https://github.com/robbi5/german-gov-domains/blob/master/data/domains.csv)**.

## Why?

There currently isn't a publicly available directory of all the domain names registered by the german government and its agencies. Such a directory would be useful for people looking to get an aggregate view of government websites and how they are hosted. For example, [Ben Balter](http://ben.balter.com) has been doing some great work [analyzing](http://ben.balter.com/2015/05/11/third-analysis-of-federal-executive-dotgovs/) the [official set of US `.gov` domains](https://github.com/GSA/data/tree/gh-pages/dotgov-domains).

This is by no means an official or a complete list. It is intended to be a first step toward a better understanding of how the government is managing its official sites.


## What can I do with it?

* Plug the CSV into [18F/domain-scan](https://github.com/18F/domain-scan) to get more data (like HTTPS support) about the domains
* Check the IPv6 reachability
* Test if the sites are reachable even without the `www.` subdomain
* ...?


## How to use

The list is populated by scrapers and static files and merged by a makefile.
To run the process yourself, checkout this repository and run:

    bundle install
    make

After everything ran, you can look into `data/domains.csv`.

## Scrapers and Sources

* `bundde-behoerden-scraper.rb`: crawls an [official government agency list](http://www.bund.de/Content/DE/Behoerden/Suche/Formular.html?nn=4641514).
* `data/source/ifg-bmvi.csv`: is a list from BMVI, aquired with a [freedom of information request](https://fragdenstaat.de/anfrage/registrierte-domains-in-maschinenlesbarer-form/)
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