require 'open-uri'
require 'json'
require 'pry'

class Predictor

  attr_accessor :full_name, :company_domain

  def initialize(path)
    @json_file = JSON.parse(File.read(path))
  end

  def guess(full_name,company_domain)
    @json_file.each do |name, email|
      if company_domain == email.split("@").last
        #binding.pry
       # name = Anna Ershova, email = anna.ershova@gmail.com
        if email.split("@").first == name.downcase.gsub(" ",".") #=> email.split("@").first == anna.ershova
          return ["#{full_name.downcase.gsub(" ",".")}@#{company_domain}"]
        elsif email.split("@").first == "#{name.downcase.split(" ")[0].split("").first}.#{name.downcase.split(" ").last}" 
          return ["#{full_name.downcase.split(" ")[0].split("").first}.#{full_name.downcase.split(" ")[-1]}@#{company_domain}"]
          # "a.pickering@hunch.com" 
        elsif email.split("@").first == "#{name.downcase.split(" ")[0]}.#{name.downcase.split(" ").last.split("").first}"
          return ["#{full_name.downcase.split(" ")[0]}.#{full_name.downcase.split(" ").last.split("").first}@#{company_domain}"]
          #anna.e
        else email.split("@").first == "#{name.downcase.split(" ")[0].split("").first}.#{name.downcase.split(" ").last.split("").first}"
          return ["#{full_name.downcase.split(" ")[0].split("").first}.#{full_name.downcase.split(" ").last.split("").first}@#{company_domain}"]
        end
      end # if
    end # end each
      ["#{full_name.downcase.gsub(" ",".")}@#{company_domain}",
      "#{full_name.downcase.split(" ")[0].split("").first}.#{full_name.downcase.split(" ")[-1]}@#{company_domain}",
      "#{full_name.downcase.split(" ")[0]}.#{full_name.downcase.split(" ").last.split("").first}@#{company_domain}",
      "#{full_name.downcase.split(" ")[0].split("").first}.#{full_name.downcase.split(" ").last.split("").first}@#{company_domain}"
      ]
  end # end guess

end # end class