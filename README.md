# JqUploadRailsPaperclip

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'jq_upload_rails_paperclip'

And then execute:

    $ bundle

The installation process is a little convoluted at this point, but I'll be working on cleaning it up in the near future.

1. Create the `uploads` table:

    ```
    $ bin/rails g jq_upload_rails_paperclip:install uploads
    $ bin/rake db:migrate
    ```

2. Add `js-routes` to your Gemfile if it isn't in there already:

    ```
    gem 'js-routes', '~> 0.9'
    ```

3. Add `background_upload_routes` to the top of your `config/routes.rb` file.

4. Add the uploads relation on `User` for back-referencing uploads. (`User`, `current_user`, and `user_signed_in?` are assumed to behave like a Devise user):

    ```
    has_many :uploads, class_name: 'JqUploadRailsPaperclip::Upload'
    ```

5. Make the Paperclip attachment `background_uploadable` by using the declaration in the class file:

    ```
    has_attached_file :profile_image, styles: { ... }
    background_uploadable :profile_image
    ```

6. Output the markup in the `_form` partial (or wherever the `form_for` is):

    ```
    = form_for @user, ... do |f|
      = background_file_field_tag f, :profile_image, class: %w( btn btn-default ) do
        i.glyphicon.glyphicon-plus
        span Upload File
    ```

7. Make sure the `jquery.fileupload-ui` CSS is being included in your `application.css` (only if you want default styling -- this is recommended)

8. Add `jq_upload_rails_paperclip` to `application.js`: (make sure this is *after* `js-routes`):

    ```
    //= require js-routes
    //= require jq_upload_rails_paperclip
    ```

9. In your controller accepting the parameters for creation / updating, make sure you permit them. The following example is for a model named Resource, with a `background_uploadable :profile_image`.

    ```
    def resource_params
      params.require(:resource).permit :remove_profile_image, :profile_image_id
    end
    ```

## Usage

TODO: Write usage instructions here

## Caveats

* You must have a `belongs_to :user` relation in the resource, if the resource is not User itself.

## Contributing

1. Fork it ( https://github.com/flagship-llc/jq_upload_rails_paperclip/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
