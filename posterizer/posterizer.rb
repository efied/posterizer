require 'yaml'

class Posterizer

  def self.parse(html)
    settings = YAML::load(File.read('settings.yml'))
    settings.each do |key, value|
      html.gsub!("{#{key}}", value)
    end

    html.gsub!("{PostViews}", (rand(100)+1).to_s)

    html
  end
end
