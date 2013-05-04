
server "root@192.168.1.130", :all

namespace :raspi do
  desc "Use this task will deploy Projecat to Raspi; don't use [cap deploy]"
  task :deploy do
    run [
      "cd projecat",
      "git pull",
      "bundle install --without deployment",
      "padrino ar:migrate -e production",
      "mkdir tmp",
      "kill `cat tmp/thin.pid`",
      "thin start -d -e production -p 3000 -a 0.0.0.0 --pid tmp/thin.pid",
      ].join(" && ")
  end

end
