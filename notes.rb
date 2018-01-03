*  Testing with RSpec * -----------------------------------------------------

in day_28 folder:
> rails new fundsy -T -d postgresql
> cd fundsy/
> rails db:create
// Created database 'fundsy_development'
// Created database 'fundsy_test'

in gemfile, add 2 gems :

    group :development, :test do
      gem 'rspec-rails'// add **********
      gem 'faker' // add **********
      # Call 'byebug' anywhere in the code to stop execution and get a debugger console
      gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    end

> bundle

> rails g rspec:install
 - new folder `spec` is created with 2 rb files

// >rails db:migrate RAILS_ENV=test   ??

> rails g model campaign title description:text goal:integer end_date:datetime
  - go to spec/models/campaign_spec.rb // this is for testing

> rspec
> rails db:migrate
> rspec
// will see pending - for future testing

go to spec/models/campaign_spec.rb


//-----------------
q = Question.new
q.valid?
q.errors.messages
q.errors.messages.has_key?(:title)

//-----------------

expect(c.errors.messages).to have_key(:title)
c.errors.messages is a hash

> rspec
// fail
go to app/models/campaign.rb add `validates:title, presence: true`
> rspec
//pass


//---------------------------
** only want to run a test on line 35
> rspec spec/models/campaign_spec.rb:35


//---------------------------------

name = nil
name.upcase // get error / throw an error
name&.upcase // get nil
