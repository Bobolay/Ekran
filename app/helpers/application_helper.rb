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
        controls: 1,
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

  def site_data(k)
    begin
      h = YAML.load(IO.read(Rails.root.join("config/site_data.yml").to_s))['site_data']
      keys = k.split(".")
      v = h
      keys.each do |k|
        v = v[k]
      end
      return v

    rescue
      return nil
    end
  end

  def social_links
    Hash[site_data("social_links").map{|k, v| [k, {icon: "svg/social/#{k}.svg", url: v}] }]
  end

  def get_canonical_url
    #param_names =
    show_canonical =  [params[:brands], params[:tags], params[:page]].any?{|arg| arg.present? }
    return if !show_canonical

    host = (ENV["#{Rails.env}.host_with_port"] || ENV["#{Rails.env}.host"])
    page_url = @_breadcrumbs.last ? host + @_breadcrumbs.last[:url] : nil
    return page_url

    if show_canonical
      route_name = params[:controller]
      #url_for(controller: params[:controller], action: :index)
      send("#{route_name}_path")
    end
  end

  def canonical_link
    canonical_url = @canonical_url.nil? ? get_canonical_url : nil
    if canonical_url.present?
      content_tag("link", "", rel: "canonical", href: canonical_url)
    end
  end

  def formatted_file_type_and_size(attachment)
    file_type = attachment.path.split("/").last.split(".").last
    file_size_in_mb = (attachment.size.to_f / 1024 / 1024).round(2)
    formatted_file_size = "#{file_size_in_mb} MB"

    "<span>#{file_type}&nbsp;</span>(#{formatted_file_size})".html_safe
  end
end
