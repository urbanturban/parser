#!/usr/bin/env ruby
require_relative 'common'

def parse_injapan(options)
  options[:xpath] = '//div[@id="content"]/div/div/div/div/div/a'
  parse(options) do |new_elements, node|
    new_elements["https://injapan.ru#{node[:href]}"] = node[:title]
  end
end

parse_injapan(url: 'https://injapan.ru/search/do.html?query=ステラ+C2000S', product: 'stella c2000s')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=ステラ+C2000HGS', product: 'stella c2000hgs')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=ステラ+1000S', product: 'stella 1000s')
parse_injapan(url: 'https://injapan.ru/search/do.html?query=S707SULT', product: 'S707SULT')