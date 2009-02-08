# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def authenticity_token
    authenticity_token_from_session_id
  end
  
  def address_to_html(with_address)
    parts = [:street_address, :suburb, :city, :country]
    content_tag 'div', nil, :class => 'address' do
      parts.map do |part|
        content_tag 'div', html_escape(with_address.send(part)), :class => part.to_s
      end
    end
  end
    
end
