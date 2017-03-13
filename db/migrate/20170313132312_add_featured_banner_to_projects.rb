class AddFeaturedBannerToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.attachment :featured_banner
    end
  end
end
