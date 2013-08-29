require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://openbama.org'
SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 0.9
  add '/bills', :changefreq => 'weekly'
  add '/legislators', :changefreq => 'weely'
  add '/votes', :changefreq => 'weekly'
  add '/committees', :changefreq => 'weekly'
  add '/lobbyists', :changefreq => 'weekly'
  add '/clients', :changefreq => 'weekly'
  add '/blog', :changefreq => 'daily'
  add '/page/about', :changefreq => 'weekly'
  add '/page/contact', :changefreq => 'weekly'
  add '/page/opengov', :changefreq => 'weekly'
end
SitemapGenerator::Sitemap.ping_search_engines # called for you when you use the rake task