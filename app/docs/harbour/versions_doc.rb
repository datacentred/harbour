module Harbour
  module VersionsDoc
    extend CurlHelper

    def self.superclass
      VersionsController
    end
    extend Apipie::DSL::Concern

    resource_description do
      resource_id 'Versions'
      api_versions *Harbour::Engine.config.api_versions.map(&:downcase)
    end

    api :GET, '', 'List all available API versions'
    description <<-EOS
      This endpoint shows all currently supported API versions, including information on their status. An API version may be:

      * `CURRENT`
        * The latest supported version.
      * `SUPPORTED`
        *  A supported older version.
      * `DEPRECATED`
        * Currently supported but soon to be retired.
      <div class="bg-info"><strong>💡 Note:</strong> This resource does not require authentication.</div>
    EOS
    example <<-EOS
# List all available API versions
curl '#{Harbour::Engine.config.public_url}'
{
  "versions": [
    {
      "id": "1",
      "status": "CURRENT",
      "links": [
        {
          "href": "http://localhost:3000/api",
          "rel":"self"
        }
      ]
    }
  ]
}
    EOS
    def index ; end
  end
end