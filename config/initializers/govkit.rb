if defined? GovKit
  GovKit.configure do |config|
    # Get an API key for Sunlight's Open States project here:
    # http://services.sunlightlabs.com/accounts/register/
    config.sunlight_apikey = '19d0d4299d62409c8c6469ca97732f37'

    ##API key for Votesmart
    # http://votesmart.org/services_api.php
    config.votesmart_apikey = 'bf85cc88aa021aa07e2db6690734c6b5'

    # API key for NIMSP. Request one here:
    # http://www.followthemoney.org/membership/settings.phtml
    config.ftm_apikey = '85c4af3d020f0524f722ce85f171f00c'
    
    # Technorati API key
    # config.technorati_apikey = 'YOUR_TECHNORATI_APIKEY'
    
    # Bing App ID
    config.bing_appid = 'YOUR_BING_APPID'
    
    # Other things you could set here include alternate URLs for
    # the APIs. See GovKit::Configuration for available attributes.
  end
end
