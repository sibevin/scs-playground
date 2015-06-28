=begin
guard 'slim', slim: { :pretty => true },
              input_root: 'src/slim',
              output_root: 'app/' do
  watch(%r'^.+\.slim$')
end
=end

require 'slim'
require 'slim/include'
require 'fileutils'
require 'uglifier'

require './config/routes.rb'

guard :compass, configuration_file: 'config/compass.rb'

coffeescript_options = {
  input: 'src/coffeescript',
  output: 'temp/js',
  patterns: [%r{^src/coffeescript/(.+\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end

module ::Guard
  class RenderSlimGuard < ::Guard::Plugin
    def initialize(options = {})
      @root_path = Pathname.new(File.dirname(__FILE__))
      super
    end

    def run_all
      render_all
    end

    def run_on_changes(paths)
      p "changed."
      render_slim_file(paths)
    end

    def run_on_modifications(paths)
      p "modified."
      render_slim_file(paths)
    end

    def run_on_addititions(paths)
      p "additions."
      render_slim_file(paths)
    end

    private

    def render(route_data, view_path)
      p "=== rander: start ==="
      p "view_path = #{view_path}"
      p "route_data = #{route_data}"
      if route_data[:layout] == nil
        layout = "src/slim/layout/application.slim"
      else
        layout = "src/slim/layout/#{route_data[:layout]}.slim"
      end
      p "layout = #{layout}"

      return unless File.file?(view_path)
      main_slim = File.read(view_path)
      meta = Hash[
        main_slim.lines.
          keep_if { |l| l.match(/^\.meta-data/) }.
          map { |l| l.gsub(/\.meta-data\ /,'').gsub(/"/,'').strip.split("=") }
      ]
      p "meta = #{meta}"
      layout_slim = File.read(layout)

      layout_html = Slim::Template.new{ layout_slim }
      main_html = Slim::Template.new{ main_slim }.render(self)
      if route_data[:template]
        template_path = "src/slim/template/#{route_data[:template]}.slim"
        p "template = #{template_path}"
        template_slim = File.read(template_path)
        template_html = Slim::Template.new{ template_slim }
        main_html = template_html.render { main_html }
      end
      page_html = layout_html.render { main_html }

      output_path = "build#{route_data[:path]}.html"
      p "output_path = #{output_path}"
      output_dir = File.dirname(output_path)
      unless File.directory?(output_dir)
        FileUtils.mkdir_p(output_dir)
      end

      File.open(output_path, 'w') do |f|
        f.puts page_html
      end
      p "=== rander: end ==="
    end

    def render_slim_file(paths = [])
      p "Some posts are modified."
      paths.each do |path|
        slim_path = path.gsub(/src\/slim\//, '')
        if slim_path =~ /layout\/application.slim/
          render_all
        else
          $routes.each do |route_data|
            if route_data[:view].is_a?(String)
              if slim_path == "#{route_data[:view]}.slim"
                render(route_data, path)
              end
            else route_data[:view].is_a?(Regexp)
              if route_data[:view].match?(slim_path)
                render(route_data, path)
              end
            end
          end
        end
      end
    end

    def render_all
      $routes.each do |route_data|
        if route_data[:view].is_a?(String)
          render(route_data, "src/slim/#{route_data[:view]}.slim")
        else route_data[:view].is_a?(Regexp)
          # TODO: handle the regex path
          if route_data[:view].match?(slim_path)
            render(route_data, path)
          end
        end
      end
    end
  end
end

guard 'render-slim-guard' do
  watch(%r{/.*\.slim$})
end

module ::Guard
  class MergeJsGuard < ::Guard::Plugin
    def initialize(options = {})
      @root_path = Pathname.new(File.dirname(__FILE__))
      super
    end

    def run_all
      merge_js
    end

    def run_on_changes(paths)
      merge_js
    end

    def run_on_modifications(paths)
      merge_js
    end

    def run_on_addititions(paths)
      merge_js
    end

    private

    def merge_js
      p "=== merge js: start ==="
      output_dir = "#{@root_path}/temp/js"
      unless File.directory?(output_dir)
        FileUtils.mkdir_p(output_dir)
      end
      File.open("#{output_dir}/app.js","w") do |f|
        # merge const js first
        Dir["/app/consts/**/*.js"].each do |src_file|
          f.write(File.read(src_file))
        end
        # merge app js
        if File.file?("#{output_dir}/app/app.js")
          File.open("#{output_dir}/app/app.js","r") do |src_file|
            f.write(File.read(src_file))
          end
        end
        # merge services, directives, controllers js in order
        folders = ["services", "directives", "controllers"]
        folders.each do |fd|
          Dir["#{output_dir}/app/#{fd}/*.js"].each do |src_file|
            f.write(File.read(src_file))
          end
        end
      end
      build_js_dir = "#{@root_path}/build/js"
      File.open("#{build_js_dir}/app.min.js", "w") do |f|
        f.write(Uglifier.compile(File.read("#{output_dir}/app.js")))
      end
      # for js debug
      system("cp #{output_dir}/app.js #{build_js_dir}/app.js")
      p "=== merge js: end ==="
    end
  end
end

guard 'merge-js-guard' do
  # only watch temp/js/app/*.js and skip temp/js/app.js
  watch(%r{^temp/js/.+/(.+\.js)$})
end