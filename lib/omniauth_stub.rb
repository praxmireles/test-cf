# frozen_string_literal: true

# Stub Response of an Ommniauth Authorization
module OmniauthStub
  def self.facebook_response
    {
      provider: 'facebook',
      uid: '1234567',
      info: {
        email: 'joe@bloggs.com',
        name: 'Joe Bloggs',
        first_name: 'Joe',
        last_name: 'Bloggs',
        image: 'http://graph.facebook.com/1234567/picture?type=square',
        verified: true
      },
      credentials: {
        token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
        expires_at: 1_321_747_205, # when the access token expires (it always will)
        expires: true # this will always be true
      },
      extra: {
        raw_info: {
          id: '1234567',
          name: 'Joe Bloggs',
          first_name: 'Joe',
          last_name: 'Bloggs',
          link: 'http://www.facebook.com/jbloggs',
          username: 'jbloggs',
          location: { id: '123456789', name: 'Palo Alto, California' },
          gender: 'male',
          email: 'joe@bloggs.com',
          timezone: -8,
          locale: 'en_US',
          verified: true,
          updated_time: '2011-11-11T06:21:03+0000',
          # ...
        }
      }
    }
  end

  def self.linkedin_response
    {
      "provider"=>"linkedin",
      "uid"=>"AbC123",
      "info"=> {
        "name"=>"John Doe",
        "email"=>"john@doe.com",
        "nickname"=>"John Doe",
        "first_name"=>"John",
        "last_name"=>"Doe",
        "location"=>"Greater Boston Area, US",
        "description"=>"Senior Developer, Hammertech",
        "image"=> "http://m.c.lnkd.licdn.com/mpr/mprx/0_aBcD...",
        "phone"=>"null",
        "headline"=> "Senior Developer, Hammertech",
        "industry"=>"Internet",
        "urls"=>{
          "public_profile"=>"http://www.linkedin.com/in/johndoe"
        }
      },
      "credentials"=> {
        "token"=>"12312...",
        "secret"=>"aBc..."
      },
      "extra"=>
      {
        "access_token"=> RecursiveOpenStruct.new(
          "token"=>"12312...",
          "secret"=>"aBc...",
          "consumer"=>nil, # <OAuth::Consumer>
          "params"=> {
            :oauth_token=>"12312...",
            :oauth_token_secret=>"aBc...",
            :oauth_expires_in=>"5183999",
            :oauth_authorization_expires_in=>"5183999",
          },
          "response"=>nil # <Net::HTTPResponse>
        ),
        "raw_info"=> {
          "firstName"=>"Joe",
          "headline"=>"Senior Developer, Hammertech",
          "id"=>"AbC123",
          "industry"=>"Internet",
          "lastName"=>"Doe",
          "location"=> { "country"=>{ "code"=>"us" }, "name"=>"Greater Boston Area" },
          "pictureUrl"=> "http://m.c.lnkd.licdn.com/mpr/mprx/0_aBcD...",
          "publicProfileUrl"=>"http://www.linkedin.com/in/johndoe"
        }
      }
    }
  end
end
