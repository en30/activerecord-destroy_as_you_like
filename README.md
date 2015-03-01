# Activerecord::DestroyAsYouLike
```ruby
class Parent
  has_many :children, dependent: :destroy_as_you_like
end
class Child
end
```

then

```
Parent#destroy
  when children have before_destroy callback
    destroy_all children
  when children have around_destroy callback
    destroy_all children
  when children have after_destroy callback
    destroy_all children
  when children have after_commit callback
    destroy_all children
  when children do not have any destroy related callback
    delete_all children
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-destroy_as_you_like', github: 'en30/activerecord-destroy_as_you_like'
```

And then execute:

    $ bundle

## Contributing

1. Fork it ( https://github.com/en30/activerecord-destroy_as_you_like/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
