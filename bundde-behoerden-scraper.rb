require 'rubygems'
require 'bundler/setup'
require 'mechanize'
require 'csv'

CATEGORIES = [
  'oberstebundesbehoerde',
  'mittlerebundesbehoerde',
  'verfassungsorgan',
  'bundesgericht',
  'oberebundesbehoerde'
]

URL = "https://www.bund.de/Content/DE/Behoerden/Suche/Formular.html?nn=4641496&cl2Categories_Einordnung=#{CATEGORIES.join('+')}&resultsPerPage=100"

@mech = Mechanize.new

def scrape_page(page)
  list_entries = page.search('//ul[@class="result-list"]/li')
  list_entries.each do |entry|
    name = entry.at_css('h3 em').next.text.gsub(/\n/, ' ').strip
    link = entry.at_css('a')

    detail_page = @mech.click link
    domain = detail_page.search('//div[@class="orgUnitHomepage"]//a').text.strip

    next if domain.nil? || domain == ''

    puts [domain, name].to_csv
  end
end

page = @mech.get URL

loop do
  scrape_page(page)
  next_page_link = page.search('//div[contains(@class,"pager")]//li[@class="next"]/a').first
  break if next_page_link.nil?
  page = @mech.click next_page_link
end