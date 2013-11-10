# -*- encoding: utf-8 -*-
# stub: pirate_game 0.0.1.20131109145744 ruby lib

Gem::Specification.new do |s|
  s.name = "pirate_game"
  s.version = "0.0.1.20131109145744"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Davy Stevenson", "Eric Hodel"]
  s.date = "2013-11-09"
  s.description = "You insouciant scalawags will share the experience of a lifetime as you play a game built atop DRb and Shoes based generally upon the phenomenon known as Spaceteam! Except with Pirates!!\n\nTeam up with your fellow pirates to plunder the high seas! Yarrrr\u{2026}.\u{2620}"
  s.email = ["davy.stevenson@gmail.com", "drbrain@segment7.net"]
  s.executables = ["game_master", "pirate_game"]
  s.extra_rdoc_files = ["History.rdoc", "Manifest.txt", "README.md"]
  s.files = [".autotest", "History.rdoc", "Manifest.txt", "README.md", "Rakefile", "bin/game_master", "bin/pirate_game", "config.json", "imgs/jolly_roger.jpg", "imgs/jolly_roger_sm.png", "imgs/pirate_ship.png", "imgs/pirate_ship_sm.png", "lib/pirate_game.rb", "lib/pirate_game/animation.rb", "lib/pirate_game/background.rb", "lib/pirate_game/boot.rb", "lib/pirate_game/bridge.rb", "lib/pirate_game/bridge_button.rb", "lib/pirate_game/client.rb", "lib/pirate_game/client_app.rb", "lib/pirate_game/game_master.rb", "lib/pirate_game/image.rb", "lib/pirate_game/log_book.rb", "lib/pirate_game/master_app.rb", "lib/pirate_game/protocol.rb", "lib/pirate_game/shoes4_patch.rb", "lib/pirate_game/stage.rb", "lib/pirate_game/timeout_renewer.rb", "lib/pirate_game/wave.rb", "lib/pirate_game/waving_item.rb", "state_diagram.graffle", "test/test_pirate_game_bridge.rb", "test/test_pirate_game_client.rb", "test/test_pirate_game_game_master.rb", "test/test_pirate_game_log_book.rb", "test/test_pirate_game_stage.rb", "test/test_pirate_game_timeout_renewer.rb", ".gemtest"]
  s.homepage = "https://github.com/davy/pirate_game"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "pirate_game"
  s.rubygems_version = "2.1.9"
  s.summary = "You insouciant scalawags will share the experience of a lifetime as you play a game built atop DRb and Shoes based generally upon the phenomenon known as Spaceteam! Except with Pirates!!  Team up with your fellow pirates to plunder the high seas! Yarrrr\u{2026}.\u{2620}"
  s.test_files = ["test/test_pirate_game_bridge.rb", "test/test_pirate_game_client.rb", "test/test_pirate_game_game_master.rb", "test/test_pirate_game_log_book.rb", "test/test_pirate_game_stage.rb", "test/test_pirate_game_timeout_renewer.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, ["~> 1.8.0"])
      s.add_runtime_dependency(%q<pirate_command>, [">= 0.0.2", "~> 0.0"])
      s.add_runtime_dependency(%q<shuttlecraft>, ["~> 0.0"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<hoe>, ["~> 3.7"])
    else
      s.add_dependency(%q<json>, ["~> 1.8.0"])
      s.add_dependency(%q<pirate_command>, [">= 0.0.2", "~> 0.0"])
      s.add_dependency(%q<shuttlecraft>, ["~> 0.0"])
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<hoe>, ["~> 3.7"])
    end
  else
    s.add_dependency(%q<json>, ["~> 1.8.0"])
    s.add_dependency(%q<pirate_command>, [">= 0.0.2", "~> 0.0"])
    s.add_dependency(%q<shuttlecraft>, ["~> 0.0"])
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<hoe>, ["~> 3.7"])
  end
end
