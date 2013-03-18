# Heroku.json

heroku.json is configuration management for Heroku, making it super simple to setup (```heroku bootstrap```) and copy (```heroku describe```) Heroku apps.

__For app creators:__ Include a heroku.json file in your project root to make running your app on Heroku as simple as ```heroku bootstrap```.

__For hackers:__ Setup any project with a heroku.json file with a single command.

## Installation

1. Get a Heroku account. If you don't have one already, create an account with [Heroku](https://api.heroku.com/signup). Your account needs to be [verified](https://dashboard.heroku.com/account) in order to use any apps, which means adding a credit card.
2. Install [Heroku Toolbelt](https://toolbelt.heroku.com/).
3. __Install heroku.json__, by running ```heroku plugins:install git@github.com:rainforestapp/heroku.json.git``` from the command line.

## Basic Usage

### Heroku bootstrap

```heroku bootstrap``` __creates an app__ on Heroku which is ready to run, based on a __heroku.json__ file. After cloning a project with a heroku.json file, you can run ```heroku bootstrap``` from the project root to install it onto Heroku. ```heroku bootstrap``` creates a new app on Heroku, installs the necessary addons, and configures the environment variables. Tada! One app, ready to go.

_Note: Some addons are charged, please refer to the [addons](https://addons.heroku.com/) website for pricing information._

### Heroku describe

```heroku describe``` generates a heroku.json file for your project. Simply run ```heroku describe``` to automatically generate a heroku.json file for your project. This will create a new file called heroku.json in your project folder which describes all of the addons and environment variables that your app depends on, and which looks something like this:

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

_Note: Although we blacklist some environment variables for you already, please check that nothing private is exported before publishing._

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
