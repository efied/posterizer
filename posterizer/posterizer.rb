require 'yaml'

class Posterizer

  def self.parse(html)
    settings = YAML::load(File.read('settings.yml'))
    settings.each do |key, value|
      html.gsub!("{#{key}}", value)
    end
    html
  end
end
