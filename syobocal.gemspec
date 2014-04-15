Gem::Specification.new do |s|
  s.name = 'syobocal'
  s.version = '0.9.0'
  s.date = '2014-04-16'
  s.summary = "Simple gem for Syoboi Calendar"
  s.description = "Simple gem for Syoboi Calendar"
  s.authors = ["xmisao"]
  s.email = 'mail@xmisao.com'
  s.files = ["lib/syobocal.rb", "lib/syobocal/rss2.rb", "lib/syobocal/rss.rb", "lib/syobocal/calchk.rb", "lib/syobocal/json.rb", "lib/syobocal/util.rb", "lib/syobocal/db.rb", "bin/anime", "bin/syobocal"]
  s.homepage = 'https://github.com/xmisao/syobocal'
  s.license = 'MIT'
  s.executables << 'anime'
  s.executables << 'syobocal'
end
