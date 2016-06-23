Gem::Specification.new do |s|
  s.name = 'syobocal'
  s.version = '0.9.1'
  s.date = Date.today.to_s
  s.summary = "Simple gem for Syoboi Calendar"
  s.description = "Syoboi Calendar is the oldest and biggest ANIME information site, supported and hosted by anime fans in Japan. This gem make it easy to download information using web APIs of this site."
  s.authors = ["xmisao"]
  s.email = 'mail@xmisao.com'
  s.files = ["lib/syobocal.rb", "lib/syobocal/rss2.rb", "lib/syobocal/rss.rb", "lib/syobocal/calchk.rb", "lib/syobocal/json.rb", "lib/syobocal/util.rb", "lib/syobocal/db.rb", "bin/syobocal-anime", "bin/syobocal"]
  s.homepage = 'https://github.com/xmisao/syobocal'
  s.license = 'MIT'
  s.executables << 'syobocal-anime'
  s.executables << 'syobocal'
end
