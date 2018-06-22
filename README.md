# MItamae::Plugin::Resource::Alternatives

This plugin is heavily inspired, and in-part, a part of the [original `alternatives` Itamae plugin](https://github.com/nishidayuya/itamae-plugin-resource-alternatives), written by [Yuya Nishida](https://github.com/nishidayuya).

## Usage

```ruby
alternatives 'vim' do
  path '/usr/bin/nvim'
end
```

```ruby
alternatives 'pinentry' do
  auto true
end
```
