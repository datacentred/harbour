require 'test_helper'

module Harbour
  module V1
    class UsersTest < ApiTest
      def user_format
        {
          "uuid"       => String,
          "email"      => String,
          "first_name" => String,
          "last_name"  => String,
          "links"      => Array,
          "projects"   => Array
        }
      end

      test "api user must be authorized to access users" do
        assert_resource_is_unauthorized "users"
      end

      test "users index has two users" do
        get '/api/users', authorized_headers
        assert_response :success
        assert_equal 2, response_body['users'].count
      end

      test "users index users belong to org1" do
        get '/api/users', authorized_headers
        emails = response_body['users'].map{|u| u['email']}
        assert emails.include? "bill.s.preston@bodacious.com"
        assert emails.include? "elizabeth@ironmaiden.com"
      end

      test "index user matches format" do
        get '/api/users', authorized_headers
        user = response_body['users'][1]
        assert_format_matches user_format, user
      end

      test "can find user 1" do
        get '/api/users/1', authorized_headers
        assert_response :success
      end

      test "can't find user 2" do
        get '/api/users/2', authorized_headers
        assert_response :not_found
      end

      test "user 1 matches format" do
        get '/api/users/1', authorized_headers  
        assert_format_matches user_format, response_body['user']
      end
    end
  end
end