Paperclip::Tinify.tinify_key = ENV['tinypng_key']
Paperclip::Tinify.environments = (ENV['tinify_environments'] || "production").split(',').map(&:to_sym)