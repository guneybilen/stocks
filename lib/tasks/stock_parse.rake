require 'open-uri'

task :load_page do
#   include ActionView::Helpers::NumberHelper
  
  @have_stock = false
  doc = Nokogiri::HTML(open("http://www.bigpara.com/borsa/canli-borsa/"))
  doc = doc.css("#sortable > ul.live-stock-item")
  counter = 0
  while(doc.xpath('//ul/@data-symbol')[counter] != nil) do
      name = doc.xpath('//ul/@data-symbol')[counter]
      
      price = doc.css("#h_td_fiyat_id_" + name).text.gsub(/,/,".")
      lowest = doc.css("#h_td_taban_id_" + name).text.gsub(/,/,".")
      highest = doc.css("#h_td_tavan_id_" + name).text.gsub(/,/,".") 
      
    #   puts "guney"
      if ( price.to_f <= lowest.to_f)
        #   puts lowest.to_f
          @have_stock = true
          File.open("big-para.html", "a") do |f|
            f.puts("Hisse: " + name + " fiyat: " + price + " taban: " + lowest + " tavan: " + highest)
          end
      end 
      
      counter +=1
  end
  
  if @have_stock == false
    File.open("big-para.html", "w") do |f|
      f.puts("Avantajli hisse senedi yok su an.")
    end
  end
      
  #stock_names = doc.xpath('//ul/@data-symbol')[0]
  #doc.css("#sortable > ul.live-stock-item data-symbol")
  #File.write("big-para.html", stock_names)
end
