require 'yaml'

class Posterizer

  def self.parse(html)
    settings = YAML::load(File.read('settings.yml'))
    settings.each do |key, value|
      #next if key == "Posts"
      html.gsub!("{#{key}}", value.to_s)
    end

    html.gsub!("{PostViews}", (rand(100)+1).to_s)

    html
  end
end
