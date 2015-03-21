# AVOS

[LeanCloud SDK](https://cn.avoscloud.com/docs/rest_api.html) for Ruby

## Installation

Add this line to your application's Gemfile:

    gem 'avos', git: "https://github.com/loveltyoic/avos-ruby-sdk.git"

And then execute:

    $ bundle

## Usage

### Configuration

```ruby
  AVOS.init do |avos|
    avos.app_id = APP_ID
    avos.app_key = APP_KEY
  end
```

### Object
+ Create Object
```ruby
  game_score = AVOS::Object.new("GameScore", {
    "score" => 1337,
    "playerName" => "Sean Plott",
    "cheatMode" => false })
```
+ Save Object
```ruby
  game_score.save
```
+ Update Object
```ruby
  game_score.update({"score" => 1000})
```
+ Delete Object
```ruby
  game_score.delete
```

### Query

```ruby
  
  query = AVOS::Query.new("Set")

  query.find(game_score.avos_id)

  query.where({"playerName" => "Sean Plott"})

  query.count({"cheatMode" => false})
```
### File

+ Upload
```ruby
  file = AVOS::File.new("folder/image_name.jpg")
```  
  If you want assign file name at avos
```ruby
  file.upload("filename_at_avos")
```
  or just
```ruby
  file.upload
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

