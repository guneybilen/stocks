require 'open-uri'

task load_page: :environment do
#   include ActionView::Helpers::NumberHelper
  
  @have_stock = false
  @ary = []
        
  doc = Nokogiri::HTML(open("http://www.bigpara.com/borsa/canli-borsa/"))
  doc = doc.css("#sortable > ul.live-stock-item")
  counter = 0
  while(doc.xpath('//ul/@data-symbol')[counter] != nil) do
      name = doc.xpath('//ul/@data-symbol')[counter]
      
      price = doc.css("#h_td_fiyat_id_" + name).text.gsub(/,/,".")
      lowest = doc.css("#h_td_taban_id_" + name).text.gsub(/,/,".")
      highest = doc.css("#h_td_tavan_id_" + name).text.gsub(/,/,".") 
      
    
      if ( price.to_f <= lowest.to_f)
      # if ( price.to_f > lowest.to_f)
        
        #   puts lowest.to_f
          @have_stock = true
          # File.open("big-para.html", "a") do |f|
            # f.puts("Hisse: " + name + " fiyat: " + price + " taban: " + lowest + " tavan: " + highest)
             @ary << "Hisse: #{name},  Fiyat:  #{price},  Taban:  #{lowest},  Tavan: #{highest} "
            # @ary << {"Hisse: " => name, "Fiyat: " => price, "Taban: " => lowest, "Tavan: " => highest}
          # end
          
      end 
      
      counter +=1
  end
  
  if @have_stock == true
    Notifier.email_friend(@ary).deliver
    # File.open("big-para.html", "w") do |f|
      # f.puts(@ary)
    # end
  else
    # sorry = "BIST'de su an avantajli bir hisse yok!"
    # Notifier.email_bad_news(sorry).deliver
  end
      
  #stock_names = doc.xpath('//ul/@data-symbol')[0]
  #doc.css("#sortable > ul.live-stock-item data-symbol")
  #File.write("big-para.html", stock_names)
end
