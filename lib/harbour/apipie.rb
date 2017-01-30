module Harbour
  def self.app_info
    <<-EOS
## Welcome to the DataCentred API documentation

This API allows you to automate operations against your DataCentred account
in a similar way to how you would automate operations against your OpenStack
infrastructure.

Operations include:

* Creating and managing users;
* Creating and managing roles for users;
* Managing OpenStack Project creation, quota adjustments, and user assignments;
* Viewing detailed usage/billing information for your account.

If you have any questions or need any help, please [raise a support ticket](https://my.datacentred.io/account/tickets)!

## 🔑 Authentication

The API uses two pieces of information to authenticate access.

* A unique access key specific to your DataCentred account;
* A secret key which is generated once. If you lose this, you will need to generate another.

Your API access key and secret key can be obtained via [my.datacentred.io](https://my.datacentred.io/account)

Use the `Authorization` header to supply your access key and secret key:

<pre class="prettyprint">
curl '#{Harbour::Engine.config.public_url}/users' \\
-H 'Authorization: Token token=<strong>"access_key:secret_key"</strong>'
{
  "users":[
    {
      "uuid": "4fd35cf93ff94a76ab206b11ae3d21e0",
      "email": "bill.s.preston@bogus.com",
      "first_name": "Bill S.",
      "last_name": "Preston",
      "links":[
        {
          "href": "http://localhost:3000/api/users/4fd35cf93ff94a76ab206b11ae3d21e0",
          "rel": "self"
        }
      ],
      "projects":[]
    }
  ]
}
</pre>

<div class="bg-info"><strong>💡 Note:</strong> The examples in this documentation export two <a href="https://en.wikipedia.org/wiki/Environment_variable#Assignment">environment variables</a> to be defined: $DATACENTRED_ACCESS and $DATACENTRED_SECRET.</div>

## 📌 API Versioning

Target specific versions and formats by using the `Accept` header:

<pre class="prettyprint">
curl '#{Harbour::Engine.config.public_url}/projects' \\
-H 'Authorization: Token token="access_key:secret_key"' \\
-H 'Accept: application/vnd.datacentred.api+json; <strong>version=1</strong>'
{
  "projects":[
    {
      "uuid": "24c1de959cb943e0bf11e5ca6c8f8ad8",
      "name": "wyld_stalyns",
      "links":[
        {
          "href": "http://localhost:3000/api/projects/24c1de959cb943e0bf11e5ca6c8f8ad8",
          "rel": "self"
        }
      ],
      "users":[]
    }
  ]
}
</pre>
    EOS
  end

  Apipie.configure do |config|
    config.app_name                = "DataCentred API"
    config.copyright               = "DataCentred Ltd #{Time.now.year}"
    config.api_base_url            = ""
    config.doc_base_url            = "/api/docs"
    config.default_version         = Harbour::Engine.config.latest_api_version.downcase.to_s
    config.api_controllers_matcher = "#{Harbour::Engine.root}/app/controllers/harbour/**/*.rb"
    config.markup                  = Apipie::Markup::Markdown.new
    config.validate                = false
    config.app_info                = Harbour::app_info
    config.link_extension          = ''
  end
end