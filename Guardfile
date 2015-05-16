guard 'slim', slim: { :pretty => true },
              input_root: 'src/slim',
              output_root: 'app/' do
  watch(%r'^.+\.slim$')
end

guard :compass, project_path: 'app/css',
                configuration_file: 'config/compass.rb'

coffeescript_options = {
  input: 'src/coffeescript/app/js',
  output: 'app/js',
  patterns: [%r{^src/coffeescript/app/js(.+\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end
