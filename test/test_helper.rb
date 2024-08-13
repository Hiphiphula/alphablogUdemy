ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def gravatar_for(user, options = { size: 80 })
      email_address = user.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
      size = options[:size]
      gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
      image_tag(gravatar_url, alt: user.username)
    end

    def sign_in_as(user)
      post login_path, params: { session: { email: user.email, password: "password" } }
    end
  end
end
