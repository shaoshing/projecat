# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

if Time.now.year == 1970
  puts "The current date is #{Time.now.strftime("%Y-%m-%d")}, which is incorrect. I will sync the time with remote server before starting."
  `ntpdate 0.pool.ntp.org`
end

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

$LOAD_PATH << "#{Padrino.root}/cat_feeder"
require 'cat_feeder'

WeiboOAuth2::Config.api_key = "1622340630"
WeiboOAuth2::Config.api_secret = "7637435cde73d981f45180107454c020"
WeiboOAuth2::Config.redirect_uri = "http://192.168.1.130:3000/admin/weibo/authorized"

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
# I18n.default_locale = :en
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  if Padrino.env == :production && ! defined?(IRB)
    CatFeeder::App.run
  end
end

Padrino.load!
