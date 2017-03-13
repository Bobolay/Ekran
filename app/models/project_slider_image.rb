class ProjectSliderImage < Attachable::Asset
  attr_accessible *attribute_names

  default_scope do
    order("id asc")
  end

  has_attached_file :data, styles: { large: "1370x768#", featured_banner: "1920x1080#" },
                    url: "/system/attachable/assets/data/:id_partition/:style/:filename",
                    path: ":rails_root/public:url",
                    processors: [:thumbnail, :tinify]
end