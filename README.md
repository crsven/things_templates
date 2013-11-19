# Things Templates

An easy(?) way to save templates for Things.app. These can include projects or
items that you often find yourself creating over and over together.
Example: a template might include the ingredients needed for a particular
recipe that you want to add to a grocery list.

## Installation
`$ gem install things_templates`

## Usage
`$ build_template <path to template>`

## Template Format
```
project: 'Project Name' <optional>
tags: <optional>
  - 'Tag 1'
  - 'Tag 2'
items:
  - 'Item 1'
  - 'Item 2'
```
Tags will be applied to all items. If a project of the same name already exists,
the existing project will be used. If you don't get a cryptic error and instead
get a cryptic note with a project and/or item IDs, pop on over to Things and
reap your rewards!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Write tests (I'm using RSpec in the `spec` folder)
5. Make sure all tests pass
5. Make sure [Cane](https://github.com/square/cane) (`bundle exec cane`) passes.
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request
