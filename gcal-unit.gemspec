
Gem::Specification.new do |s|
  s.specification_version = 2 if s.respond_to? :specification_version=
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.rubygems_version = '1.3.5'

  s.name              = 'gcal-unit'
  s.version           = '1.0.0'
  s.date              = '2012-08-30'
  s.rubyforge_project = 'gcal-unit'

  s.summary     = "Pimp ass API wrapper for the Google Calendar API."
  s.description = "Wraps HTTP calls for the Google Calendar API."

  s.authors  = ["Brilliant Fantastic"]
  s.email    = 'support@brilliantfantastic.com'
  s.homepage = 'http://github.com/brilliantfantastic/gcal-unit'

  s.require_paths = %w[lib]
  s.executables = []

  s.rdoc_options = ["--charset=UTF-8"]
  s.extra_rdoc_files = %w[README.md]

  s.add_dependency('httparty', "~> 0.8.0")

  ## Leave this section as-is. It will be automatically generated from the
  ## contents of your Git repository via the gemspec task. DO NOT REMOVE
  ## THE MANIFEST COMMENTS, they are used as delimiters by the task.
  # = MANIFEST =
  s.files = %w[
    Gemfile
    README.md
    Rakefile
    bootstrapper/Gemfile
    bootstrapper/config.ru
    example.env
    gcal-unit.gemspec
    lib/gcal_unit.rb
    lib/gcal_unit/authorization.rb
    lib/gcal_unit/calendar.rb
    lib/gcal_unit/calendar_list.rb
    lib/gcal_unit/client.rb
    lib/gcal_unit/configuration.rb
    lib/gcal_unit/errors.rb
    lib/gcal_unit/event.rb
    spec/lib/gcal_unit/authorization_spec.rb
    spec/lib/gcal_unit/calendar_list_spec.rb
    spec/lib/gcal_unit/calendar_spec.rb
    spec/lib/gcal_unit/configuration_spec.rb
    spec/lib/gcal_unit/event_spec.rb
    spec/spec_helper.rb
  ]
  # = MANIFEST =

  s.files.reject! { |f| f.include?("bootstrapper") || f.include?("example.env") }
end
