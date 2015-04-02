class Bookmark < ActiveRecord::Base
  belongs_to :topic
  after_create :embedly_url

  require "embedly"
  require "json"

  private

  def embedly_url
    embedly_api = Embedly::API.new :key => ENV["EMBEDLY_API_KEY"],
              :user_agent => "Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)"
    url = self.url        
    obj = embedly_api.extract :url => url
    puts JSON.pretty_generate(obj[0].marshal_dump) 
  end 
end
