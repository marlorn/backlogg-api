module Backlogg

  module Api

    module V1

      class ApplicationController < Sinatra::Base

        register Sinatra::ActiveRecordExtension # Is this needed?
        register Sinatra::Initializers
        helpers Sinatra::Param
        include Backlogg::Models
        include Backlogg::Serializers

        before do
          content_type :json
          response.headers["Access-Control-Allow-Headers"] = "Origin, X-Requested-With, Content-Type, Accept"
          response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
          # response.headers["Content-Type"] = "application/x-www-form-urlencoded, application/json"
          response.headers["Access-Control-Allow-Origin"] = "*"

          # The following has been deprecated in favor of the 'rack-contrib'
          # gem.  More specifically, the PostBodyContentTypeParser class it
          # provides.
          #
          # See http://samurails.com/tutorial/cors-with-angular-js-and-sinatra/
          # See http://stackoverflow.com/questions/12131763/sinatra-controller-params-method-coming-in-empty-on-json-post-request
          #
          # if request.method == :post
          #   begin
          #     params.merge! JSON.parse(request.env["rack.input"].read)
          #   rescue JSON::ParserError
          #     logger.error "Cannot parse request body."
          #   end
          # end

        end

        # not_found do
        #   halt 404, {errors: {}, message: "URL not found"}.to_json
        # end

        get '/ping' do
          "pong!"
        end

        options '*' do
          status 200
        end

      end

    end

  end

end