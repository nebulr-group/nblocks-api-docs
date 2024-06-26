# Unique header generation
require './lib/unique_head.rb'

# Global Variables
set :api_key, 'YOUR_APP_API_KEY'
set :app_id, 'YOUR_APP_ID'
set :account_api_url, 'https://account-api.nebulr-core.com'
set :account_api_host, 'account-api.nebulr-core.com'
set :admin_api_url, 'https://admin-api.nblocks.cloud'
set :admin_api_host, 'admin-api.nblocks.cloud'
set :communication_api_url, 'https://communication-api.nebulr-core.com'
set :communication_api_host, 'communication-api.nebulr-core.com'
set :file_api_url, 'https://file-api.nebulr-core.com'
set :file_api_host, 'file-api.nebulr-core.com'
set :auth_url, 'https://auth.nblocks.cloud'
set :auth_host, 'auth.nblocks.cloud'
set :backendless_api_url, 'https://backendless.nblocks.cloud'
set :backendless_api_host, 'backendless.nblocks.cloud'
set :cloud_views_url, 'https://app.nblocks.cloud'
config[:api_key]
config[:app_id]
config[:account_api_url]
config[:account_api_host]
config[:admin_api_url]
config[:admin_api_host]
config[:communication_api_url]
config[:communication_api_host]
config[:file_api_url]
config[:file_api_host]
config[:auth_url]
config[:auth_host]
config[:cloud_views_url]

# Markdown
set :markdown_engine, :redcarpet
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    disable_indented_code_blocks: true,
    prettify: true,
    strikethrough: true,
    tables: true,
    with_toc_data: true,
    no_intra_emphasis: true,
    renderer: UniqueHeadCounter

# Assets
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'

# Activate the syntax highlighter
activate :syntax
ready do
  require './lib/monokai_sublime_slate.rb'
  require './lib/multilang.rb'
end

activate :sprockets

activate :autoprefixer do |config|
  config.browsers = ['last 2 version', 'Firefox ESR']
  config.cascade  = false
  config.inline   = true
end

# Github pages require relative links
activate :relative_assets
set :relative_links, true

# Build Configuration
configure :build do
  # We do want to hash woff and woff2 as there's a bug where woff2 will use
  # woff asset hash which breaks things. Trying to use a combination of ignore and
  # rewrite_ignore does not work as it conflicts weirdly with relative_assets. Disabling
  # the .woff2 extension only does not work as .woff will still activate it so have to
  # have both. See https://github.com/slatedocs/slate/issues/1171 for more details.
  activate :asset_hash, :exts => app.config[:asset_extensions] - %w[.woff .woff2]
  # If you're having trouble with Middleman hanging, commenting
  # out the following two lines has been known to help
  activate :minify_css
  activate :minify_javascript
  # activate :gzip
end

# Deploy Configuration
# If you want Middleman to listen on a different port, you can set that below
set :port, 4567

helpers do
  require './lib/toc_data.rb'
end
