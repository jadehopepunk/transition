
class PinImagesController < ApplicationController
  COLOURS = {:green => 67, :yellow => 37, :blue => 125, :red => 11, :purple => 164}
  
  def show
    @filename = create_pin_image_file
    
    respond_to do |format|
      format.png do
        if @filename
          send_file_inline(@filename)
        else
          render :nothing => true, :status => 404
        end
      end
    end
  end
  
  protected
  
    def send_file_inline(filename)
      send_file(filename, :type => 'image/png', :disposition => 'inline')
    end
  
    def create_pin_image_file
      colour_name, number = name_parts
      return nil if colour_name.blank? || number.blank?
      
      convert_file(colour_name, number)
      destination_full_filename(colour_name, number)
    end
    
    def convert_file(colour_name, number)
      length = number.to_s.length
      image_x = 20
      image_y = 23
      
      if (length <= 2)
        pos_x = (image_x - 7 * length) / 2 + 1;
      else
        pos_x = (image_x - 7 * length) / 2 + 2;
      end
      
      FileUtils.mkdir_p(final_images_dir) unless File.exists?(final_images_dir)
      system "convert #{colour_full_filename(colour_name)} -draw \"text #{pos_x},14 '#{number}'\" #{destination_full_filename(colour_name, number)}"
    end
    
    def as_string(number, digits = 3)
      number.to_s.rjust(digits, 0.to_s)
    end
    
    def colour_full_filename(colour_name)
      File.join(RAILS_ROOT, 'public', 'images', 'blank_pins', "#{colour_filename(colour_name)}.png")
    end
    
    def destination_full_filename(colour_name, number)
      File.join(final_images_dir, "#{colour_name}-#{number}.png")
    end
    
    def final_images_dir
      File.join(RAILS_ROOT, 'public', 'pin_images')
    end
    
    def colour_filename(colour_name)
      as_string(colour_number(colour_name))
    end
    
    def colour_number(colour_name)
      COLOURS[colour_name.to_sym] || 1
    end
    
    def name_parts
      params[:id].blank? ? [] : params[:id].split('-')
    end
  
end
