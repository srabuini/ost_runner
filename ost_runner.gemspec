libdir = File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'ost_runner/version'

Gem::Specification.new do |spec|
  spec.name = 'ost_runner'
  spec.version = OstRunner::VERSION
  spec.authors = ['Sebastian Rabuini']
  spec.email = ['sebas@wasabitlabs.com']

  spec.summary = 'ActiveJob Ost Worker'
  spec.description = 'Use Ost as your ActiveJob backend'
  spec.homepage = 'https://github.com/srabuini/ost_runner.rb'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ost', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'minitest', '~> 5.10'
  spec.add_development_dependency 'rake', '~> 12.0'
end
