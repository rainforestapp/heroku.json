# Heroku.json

heroku.json is configuration management for Heroku, making it super simple to setup (import) and copy (export) Heroku apps. The hardest part about hacking on Open Source projects tends to be getting a working version running. heroku.json makes it easy!

__For app creators:__ Include a heroku.json file in your project root to make running your app a one-liner

__For hackers:__ Setup any project with a heroku.json file with a single line of code

## Installation

### Get a Heroku account
If you don't have one already, create an account with (Heroku)[https://api.heroku.com/signup]. Your account needs to be (verified)[https://dashboard.heroku.com/account] in order to use any apps, which means adding a credit card.

### Install Heroku Toolbelt

Install (Heroku Toolbelt)[https://toolbelt.heroku.com/].

### Install Heroku.json plugin

Run:

```heroku plugins:install git@github.com:rainforestapp/heroku.json.git```



## Basic Usage

### Bootstrapping a project

If you've cloned a project which has a heroku.json file just run:

```heroku bootstrap```

All the addons required will be installed as well as the environment config!

Note: Some addons are charged, please refer to the (addons)[https://addons.heroku.com/] website for pricing information.

### Making a heroku.json file for your project
Just run:

```heroku describe```

This will create a new file called heroku.json in your project folder, it should look something like this:

```json
{
  "addons": [
    "redistogo:nano"
  ],
  "env": {
    "TEST": "testing"
  }
}
```

Although we blacklist some environment variables for you already, please check that nothing private is exported before publishing.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
