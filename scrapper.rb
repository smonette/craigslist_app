# scrapper.rb
require 'nokogiri'
require 'open-uri'
require 'awesome_print'




def filter_links(todays_rows)
  # takes in todays_rows and returns uses
  # regex to only return links
  # that have "pup", "puppy", or "dog"
  # keywords
  results = []
  term = (/(puppy|puppies|pup|doggies|dog)/i)

  todays_rows.each do |item|
    if item.css('a').text.match(term)

     results.push(
      {title: item.css('a').text, posted: item.css('.date').text  })

    end
  end
  ap results
end


def get_todays_rows(doc, date_str)
  #  1.) open chrome console to look in inside p.row to see
  #  if there is some internal date related content

  #  2.) figure out the class that you'll need to select the
  #   date from a row
  todays_rows = []

  rows = doc.css('.content p.row')
  rows.each do |item|
    if item.css('span.date').text == date_str
      todays_rows.push(item)
    end
  end
  filter_links(todays_rows)
end



def get_page_results(date_str)
  # url = "http://sfbay.craigslist.org/sfc/pet/"
  url = open('pets.html').read
  # page = Nokogiri::HTML(open(url))
  page = Nokogiri::HTML(url)
  get_todays_rows(page, date_str)
end

# def search(date_str)
#   get_page_results(date_str)
# end

# want to learn more about
# Time in ruby??
#   http://www.ruby-doc.org/stdlib-1.9.3/libdoc/date/rdoc/Date.html#strftime-method
today = Time.now.strftime("%b %d")
# search(today)
get_page_results("Aug 12")


