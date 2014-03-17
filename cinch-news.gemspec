Gem::Specification.new do |s|
  s.name = "cinch-news"
  s.version = '2.0'
  s.authors = ["Richard Banks"]
  s.email = ["namaste@rawrnet.net"]
  s.license = 'MIT'
  s.homepage = "https://github.com/RawrNet/cinch-news"
  s.summary = "A news gem/plugin for the Cinch IRC bot framework."
  s.description = "A news gem/plugin for the Cinch IRC bot framework " +
    "that uses a FeedZilla API. " +     
    "You can visit irc://rawr.sinsira.net #Lobby to get help, report issues " +
    ", test the gem, or just chat."

  s.files = `git ls-files app lib`.split("\n")
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'

  s.add_dependency 'cinch', '~> 2.1.0'
  s.add_dependency 'cinch-toolbox', '~> 1.1.2'
end