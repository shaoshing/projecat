


# Installation

```bash
bundle install
padrino rake ar:migrate
padrino rake db:seed
padrino start
```

# Deployment

```bash
cap raspi:deploy
```

# Controlling the devices

> padrino console

Avaialble class for controlling the devices

* CatFeeder::Camera
* CatFeeder::FeedingDevice
* CatFeeder::EatingDetectDevice
* CatFeeder::Beeper

Example Usage:

```ruby
CatFeeder::FeedingDevice.drop
CatFeeder::Beeper.beep
```
