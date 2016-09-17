require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'json'
require 'addressable'
require 'csv'

SKIP_EMPTY_STATES = true

# Use the Wikidata Query Service (https://query.wikidata.org) to test this:
QUERY = <<-EOQ.freeze
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
PREFIX p: <http://www.wikidata.org/prop/>
PREFIX ps: <http://www.wikidata.org/prop/statement/>
PREFIX pq: <http://www.wikidata.org/prop/qualifier/>

SELECT DISTINCT ?website ?name ?state
WHERE
{
  ?q p:P31 ?statement .
  ?statement ps:P31/wdt:P279* wd:Q262166 .
  MINUS { ?statement pq:P582|pq:P576 ?x } .  # Without already gone entries (end date or dissolved)
  ?q wdt:P856 ?website .
  ?q rdfs:label ?name filter (lang(?name) = "de") .
  ?q wdt:P131* ?qstate .
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
  state = ''
  state = row['state']['value'] unless row['state'].nil?
  state = strip_iso3166_2_country(state) unless state.empty?

  next if state.empty? && SKIP_EMPTY_STATES

  uri = Addressable::URI.parse(website).normalize
  domain = clean_domain(uri.host)

  puts [domain, name, state].to_csv
end
