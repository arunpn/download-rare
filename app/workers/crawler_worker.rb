require 'rubygems'
require 'nokogiri'
require 'open-uri'

class CrawlerWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :crawler, :backtrace => true
  
  def perform(season_id, url)

    doc = Nokogiri::HTML(open(url))

    # for popbrap parent directory
    if doc.css("br+ a").size > 0
      base_url = "http://dl.popbrap.org"

      doc.css("br+ a").each_with_index do |entry, index|
        full_url = base_url + entry["href"]
        episode_number = index +=1
        SeasonsWorker.perform_async(season_id, episode_number, full_url)
      end

    # for http://dl1.m-dl.in/
    elsif doc.css("a+ a").size > 0      
      doc.css("a+ a").each_with_index do |entry, index|
        full_url = url + entry["href"]
        episode_number = index +=1
        SeasonsWorker.perform_async(season_id, episode_number, full_url)
      end

    # for http://dl1.m-dl.in/ other differently formated pages
    elsif doc.css("a").size > 0      
      doc.css("a").each_with_index do |entry, index|
        format = entry["href"].split('.').last
        unless format.eql?('php')
          full_url = url + entry["href"].sub("./","")
          episode_number = index +=1
          SeasonsWorker.perform_async(season_id, episode_number, full_url)
        end
      end
    end
  end
end