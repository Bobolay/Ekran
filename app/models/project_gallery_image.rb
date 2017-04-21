class ProjectGalleryImage < Attachable::Asset
  attr_accessible *attribute_names

  default_scope do
    order("id asc")
  end

  has_attached_file :data, styles: { width33: "635x500#", width50: "960x540#", width100: "1920x1080>" },
                    url: "/system/attachable/assets/data/:id_partition/:style/:filename",
                    path: ":rails_root/public:url"
end