require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'json'
require 'addressable'
require 'csv'

# Use the Wikidata Query Service (https://query.wikidata.org) to test this:
QUERY = <<-EOQ.freeze
SELECT ?website ?name ?state
WHERE
{
  ?q wdt:P31 wd:Q262166 .
  ?q wdt:P856 ?website .
  ?q rdfs:label ?name filter (lang(?name) = "de") .
  ?q wdt:P131 ?qstate .
  ?qstate wdt:P31 wd:Q1221156 .
  ?qstate wdt:P300 ?state .
}
EOQ

def clean_domain(domain)
  domain.downcase.gsub(/^www./, '')
end

def strip_iso3166_2_country(str)
  str.split('-', 2).last
end

uri = URI('https://query.wikidata.org/bigdata/namespace/wdq/sparql')
uri.query = URI.encode_www_form(
  query: QUERY,
  format: 'json'
)

response = uri.read

if response.status.first.to_i != 200
  puts "# Got error: #{response.status}"
  exit 1
end

data = JSON.parse(response)

data['results']['bindings'].each do |row|
  website = row['website']['value']
  name = row['name']['value']
  state = row['state']['value']
  state = strip_iso3166_2_country(state)

  uri = Addressable::URI.parse(website).normalize
  domain = clean_domain(uri.host)

  puts [domain, name, state].to_csv
end
