server "root@192.168.1.130", :all

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

namespace :raspi do
  desc "Use this task will deploy Projecat to Raspi; don't use [cap deploy]"
  task :deploy do
    run [
      "cd projecat",
      "git pull",
      "bundle install --without deployment",
      "padrino rake ar:migrate -e production",
      "kill `cat tmp/thin.pid` && rm tmp/thin.pid",
      "thin start -d -e production -p 3000 -a 0.0.0.0 --pid tmp/thin.pid",
      ].join(" && ")
  end

end
