module ApplicationHelper
  def url_for_collection_page(collection, page)
    klass = collection.model

    #if klass == Article
    base_url = klass.try(:tag_url, nil, @selected_tags_url_fragments) || klass.base_url
    #elsif klass == Product
    #  base_url = collection.first.category.tag_url(nil, @selected_tags_url_fragments)
    #end

    base_url + "/page/" + page.to_s
  end

  def self.formatted_date(date)
    if date.nil?
      return ""
    end

    month = date.month
    day = date.day
    year = date.year
    month_name = I18n.t("genitive_month_names")[month - 1]
    day_str = day >= 10 ? day.to_s : "0#{day}"
    "#{day_str} #{month_name}, #{year}"
  end

  def youtube_video_iframe(video_key, iframe_id = nil, options = {}, html_safe = true)
    defaults = {
        modestbranding: 1,
        controls: 0,
        showinfo: 0,
        wmode: "transparent",
        enablejsapi: 1,
        widgetid: 1,
        autoplay: 0,
        autohide: 1,
        loop: 1,
        version: 3,
        playlist: video_key,
        rel: 0
    }
    options = defaults.merge(options)
    iframe_url_options = options

    iframe_url_options_str = iframe_url_options.map{|k, v| "#{k}=#{v}" }.join("&")
    iframe_url = "https://www.youtube.com/embed/#{video_key}?#{iframe_url_options_str}"
    iframe_html_attributes = {
        id: iframe_id,
        frameborder: 0,
        allowfullscreen: 1,
        title: "YouTube video player",
        width:  640, # 1280
        height: 360, # 720
        src: iframe_url,
        class: "youtube-video"
    }

    iframe_html_attributes_str = iframe_html_attributes.map{|k, v| "#{k}='#{v}'" }.join(" ")
    str = "<iframe #{iframe_html_attributes_str}></iframe>"
    if html_safe
      str.html_safe
    else
      str
    end
  end

  def main_menu
    brands_children = @menu_featured_brands.map{|b| {name: raw(b.name), active: false, url: b.url, resource: b } }
    recursive_menu([
        {key: :about_us, has_active: @page_instance.is_a?(Vacancy)},
        "projects", 
        {key: :partnership, children: PartnershipArticle.published}, 
        {key: :brands, children: brands_children}, 
        {key: :services, children: Service.published}, 
        {key: :media, children: [:media_news, :media_blog, :media_video, :media_press]}, 
        :contacts])
  end
end
