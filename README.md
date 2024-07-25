# with_record

[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)
[![https://www.patreon.com/igorkasyanchuk](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/patron.svg?raw=true)](https://www.patreon.com/igorkasyanchuk)

This gem could DRY your code and return association/relation with additioanl records. Could be used in case you have form with soft-deleted value. 

**The example of problem:**

You have 2 models: User and Project. User has many projects. Project belongs to "assignee" (or author).

Let's say you have "soft-delete" (for example using paranoia" gem) and deleted user. Same time, all projects are still available (you just have such logic).

Now you want to edit the project. And in the form you have a dropdown with all active users. In this case list will be blank (because user was deleted).

So usually you need to do something like:

```slim
# just an example with problem (!!!)
= f.input :assignee_id, as: :select, collection: User.all + [User.unscoped.find_by(id: f.object.assineed_id)]
```

But now you can do the following:
```slim
# just an example with solution
= f.input :assignee_id, as: :select, collection: User.all.with_record(f.object.assineed_id)
```

And as a bonus you can also call scopes for example:

```ruby
User.all.with_record(f.object.assineed_id).ordered` # to return by first_name
```

Or

```ruby
@project.users.with_record(42).ordered # to include user by ID
@project.users.with_records(42, 43, 44).ordered # to include user by ID's
```

## Usage

This gem is adding two methods to ActiveRecord Relations and Associations - `with_record(...)` and `with_records(...)`.

You can do the following:

```ruby
    u1 = User.create(name: 'John')
    u2 = User.create(name: 'Bob')

    p1 = u1.projects.create(name: 'apple')
    p2 = u2.projects.create(name: 'google')
    p3 = u2.projects.create(name: 'amazon')

    assert_equal u1.projects.with_record(p2), [p1, p2]
    assert_equal u1.projects.with_records(p2, p3), [p1, p2, p3]
    assert_equal u1.projects.with_records([p2, p3]), [p1, p2, p3]

    assert_equal Project.where(id: p1.id).with_record(p2), [p1, p2]
    assert_equal Project.where(id: p1.id).with_records(p2, p3), [p1, p2, p3]
    assert_equal Project.where(id: p1.id).with_records([p2, p3]), [p1, p2, p3]

    assert_equal Project.where(id: p1.id).with_record(nil), [p1]    
    assert_equal Project.where(id: p1.id).with_records(nil), [p1]
 ```


## Installation
Add this line to your application's Gemfile:

```ruby
gem 'with_record'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install with_record
```

## How it works and limitations

- it's adding 2 methods to AR Relations and Associations.
- it's executing original scope, returning and ID's (or other PK values), then adding a new ID into it and returning a new releation
- joins, includes, ... before call `.with_record` won't be returned in final scope

## Contributing

You are welcome to contribute.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/)

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/?utm_source=github&utm_medium=bottom&utm_campaign=with_record)
