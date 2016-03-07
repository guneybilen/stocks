
require 'open-uri'

task load_page2: :environment do
#   include ActionView::Helpers::NumberHelper
  
  @have_stock = false
  @ary = []
        
  doc = Nokogiri::HTML(open("http://www.barchart.com/stocks/nasdlow.php"))
#   doc = doc.css("#dt1_APPF > td:nth-child(1) > a:nth-child(1)").text
  
  counter = 0
  doc.css('#dt1 > tbody:nth-child(2) > tr').each do
#   while(doc.xpath('//ul/@data-symbol')[counter] != nil) do
    #   name = doc.xpath('//ul/@data-symbol')[counter]
     sembol = doc.css('tbody tr td.ds_symbol a')[counter].text
    
     sym = doc.css("#dt1_#{sembol} > td:nth-child(1)")
     sym = doc.css("#dt1_#{sembol} > td:nth-child(1) > a:nth-child(1)").text
     name = doc.css("#dt1_#{sembol} > td:nth-child(2) > a:nth-child(1)").text
     last_price = doc.css("#dt1_#{sembol}_last").text
     high_price = doc.css("#dt1_#{sembol}_high").text
     low_price = doc.css("#dt1_#{sembol}_low").text
     time = doc.css("#dt1_#{sembol}_displaytime").text
      
      
     if ( last_price.to_f <= low_price.to_f)
        
        @have_stock = true
        # File.open("big-para.html", "w") do |f|
          # f.puts("Hisse: " + name + " fiyat: " + price + " taban: " + lowest + " tavan: " + highest)
           @ary << "Symbol: #{sym}, Hisse: #{name},  Fiyat:  #{last_price},  Taban:  #{low_price},  Tavan: #{high_price}, Time: #{time} "
          # f.puts @ary
        # end
          
     end 
      
      counter +=1
  end
  
  if @have_stock == true
    note = "Nasdaq Hisse Avantaji"
    Notifier.email_friend(@ary, note).deliver
    # File.open("big-para.html", "w") do |f|
      # f.puts(@ary)
    # end
  else
    sorry = "Nasdaq'da su an avantajli bir hisse yok!"
    Notifier.email_bad_news(sorry).deliver
  end
      
  #stock_names = doc.xpath('//ul/@data-symbol')[0]
  #doc.css("#sortable > ul.live-stock-item data-symbol")
  #File.write("big-para.html", stock_names)
end
