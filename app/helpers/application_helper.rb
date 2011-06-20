module ApplicationHelper

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def number_to_sek (number)
    number_to_currency(number, {:unit       => "kr",
                                :separator  => ",",
                                :delimiter  => " ",
                                :format     => "%n %u",
                                :precision  => 0})
  end

  def number_to_sek_decimals (number)
    number_to_currency(number, {:unit       => "kr",
                                :separator  => ",",
                                :delimiter  => " ",
                                :format     => "%n %u",
                                :precision  => 2})
  end

  def retailer_link(retailer, price)
    if price.url.blank?
      retailer.profile.url
    else
      retailer.profile.productURL + price.url
    end
  end
end
