class YahoosController < ApplicationController

 ENV["SSL_CERT_FILE"] = "./cacert.pem"
 require "open-uri"
 require "nokogiri"
 require "net/https"
 MANSHON = "https://www.kenbiya.com/pp3/s/"
 LINK_HEAD = "https://www.kenbiya.com"

 def index
   man_list = []
   @data_list = Array.new(3800).map{Array.new(3)}
   i = 0

   for num in 2..10 do
     man_list.push(MANSHON + "n-" + num.to_s + '/')
   end

  for num in 0..man_list.length do

     url_list = []
     p man_list[num]

     begin
       @doc = Nokogiri::HTML(open(man_list[num]),nil,"utf-8")
     rescue => e
       p "res1"
       e = Exception.new
       next
     end

     @doc.xpath('//div[@class="box_table_main"]').each do |table|
       table.css('a').each do |a|
         if a[:href].include?("re")
           url_list.push(LINK_HEAD + a[:href])
         end
       end
     end

     url_list.each do |sub|
       p sub
       
       begin
         sleep(0.1)
         @sub_page = Nokogiri::HTML(open(sub))

          @data_list[i][0] =  @sub_page.xpath('//div[@id="com_info_lite"]/div/h3').inner_text
          @data_list[i][1] = @sub_page.xpath('//p[@class="address"]').inner_text
          @data_list[i][2] = @sub_page.xpath('//p[@class="phone"]').inner_text

         i += 1
       rescue => e
         p "res2"
         e = Exception.new
         next
       end

     end
  end


 end

end

