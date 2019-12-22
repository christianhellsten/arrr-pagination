# Arrr::Pagination

![Pagination for ActiveRecord](https://github.com/christianhellsten/arrr-pagination/raw/master/screenshot.png?raw=true "Pagination for ActiveRecord")

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arrr-pagination', github: 'christianhellsten/arrr-pagination'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arrr-pagination

## Usage

```ruby
require 'arrr-pagination'

class EventsController < ApplicationController
  def index
    @events, @pagination = Arrr::Pagination.call(
      current_account.events.order(created_at: :desc),
      per_page: 1,
      page: params.fetch(:page, 0)
    )
  end
end
```

## View

With next and previous, without page links:

```slim
- p = params.permit
- if @pagination.previous_page || @pagination.next_page
  .pagination
    - if @pagination.previous_page
      a.btn.btn-link href=url_for(p.merge(page: nil)) ‹
      a.btn.btn-link href=url_for(p.merge(page: @pagination.previous_page)) = t('previous')
    - if @pagination.next_page
      a.btn.btn-link href=url_for(p.merge(page: @pagination.next_page)) = t('next')
      a.btn.btn-link href=url_for(p.merge(page: @pagination.page_count - 1)) ›
```

With next, previous, and page links:

```slim
- p = params.permit
- if @pagination.previous_page || @pagination.next_page
  .pagination
    - if @pagination.previous_page
      a.btn.btn-link href=url_for(p.merge(page: nil)) ‹
      a.btn.btn-link href=url_for(p.merge(page: @pagination.previous_page)) = t('previous')
      - ([0, @pagination.page-4].max..@pagination.page-1).each do |page|
        li
          a href=url_for(p.merge(page: page)) #{page+1}
    - if @pagination.next_page
      - (@pagination.page+1..[@pagination.page_count-1, @pagination.page+4].min).each do |page|
        li
          a href=url_for(p.merge(page: page)) #{page+1}
      a.btn.btn-link href=url_for(p.merge(page: @pagination.next_page)) = t('next')
      a.btn.btn-link href=url_for(p.merge(page: @pagination.page_count - 1)) ›
```


## Performance

Performance is :thumbsup:

## Plugins

There are no plugins :electric_plug:.

## Advanced usage

:thumbsup:

## Bootstrap integration

:thumbsup:

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/christianhellsten/arrr-pagination. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arrr::Pagination project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/christianhellsten/arrr-pagination/blob/master/CODE_OF_CONDUCT.md).
