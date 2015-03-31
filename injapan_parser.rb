#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require_relative 'common'
require_relative 'send_message'

def parse(url) 

  $redis = init_redis

  html = open(url)
  doc = Nokogiri::HTML(html)
  
  new_elements = Hash.new
  doc.xpath('//div[@id="content"]/div/div/div/div/div/a').each do |node|
    unless $redis.sismember(url,node[:href])
       new_elements["https://injapan.ru#{node[:href]}"] = node[:title]
       $redis.sadd(url, node[:href])
    end
  end

  send_message("New results for url: #{url}", 
    hash_to_html_list(new_elements)) if new_elements.any?

end

parse('https://injapan.ru/search/do.html?query=stella+C2000S')
parse('https://injapan.ru/search/do.html?query=stella+1000S')
parse('https://injapan.ru/search/do.html?query=S707SULT')