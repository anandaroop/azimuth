Azimuth
===

**Azimuth** is a playground for experiments in cartography at Artsy.

It consists of:

* a Rails 5 backend, built with [Kinetic](https://github.com/artsy/kinetic) so that it can talk to Gravity, and can be extended with custom server-side functionality
* [Leaflet](http://leafletjs.com), a full-featured client-side library for building interactive web maps
* A few lightweight patterns so you can quickly get hacking

The goal here is to optimize for ease and speed of iteration and for **<span style="color:#6e1fff">F</span><span style="color:#f1af1b">U</span><span style="color:#f7625a">N</span>**. [Contributions are welcomed.](docs/00_how_to_contribute.md)

## Meta

* __State:__ experimental
* __GitHub:__ [https://github.com/artsy/azimuth/](https://github.com/artsy/azimuth/)
* __Point people:__ [@anandaroop](https://github.com/anandaroop)

## Setup

0. Fork this repo, and clone your copy to your local machine

0. [Find or create your `ClientApplication` and access credentials](https://github.com/artsy/gravity/blob/master/doc/ApiAuthentication.md#get-an-application-key) in a Gravity rails console.

  * Make sure the `ClientApplication` includes `"http://localhost:9000"` in its `redirect_urls`. (If you are using a different port, you can set it in the `.env` file, below)

0. Copy `.env.example` to `.env` and update with your desired ENV variables

  * Defaults to a Gravity installation running on localhost but you can easily point to the staging API

  ~~~sh
  artsy_url=https://staging.artsy.net
  gravity_url=https://stagingapi.artsy.net
  # etc
  ~~~

  * You can change the default port number, e.g.

  ~~~sh
  PORT=9001
  ~~~

0. Set up and bundle the app

  ~~~
  $ cd azimuth
  $ bundle install
  ~~~

  If the bundle step fails when trying to fetch private Artsy gems, you may need to:

  0. Create a [personal access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use/) for command line use
  0. [Run `bundle config`](https://gist.github.com/sebboh/f1dfe4f096746c45f3e9ea06a09743a0) with your new token

0. Start the server

  ~~~
  $ bundle exec foreman start
  ~~~

## Contribute

Once you're up and running, here is a [step-by-step guide](docs/00_how_to_contribute.md) to contributing a new map.

Have fun!

![hackathon-prototype](https://cloud.githubusercontent.com/assets/140521/17833420/d2126a0e-66ea-11e6-8435-43214e422675.png)

