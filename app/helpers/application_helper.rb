module ApplicationHelper

  def map_title(title_string)
    return if title_string.blank?
    # window title
    content_for :application_title do 
      "#{title_string} | Artsy Azimuth"
    end
    # map overlay with title + desc
    haml_tag :div, class: 'map-meta' do
      haml_tag :div, class: 'map-meta__backnav' do
        chevron = capture_haml { haml_tag :span, class: 'icon-chevron-left' }
        haml_concat link_to "#{chevron} back to index".html_safe, root_path
      end
      haml_tag :h1, class: 'map-meta__title' do
        haml_concat title_string
      end
      if block_given?
        haml_tag :div, class: 'map-meta__description' do
          yield
        end
      end
    end
  end

end
