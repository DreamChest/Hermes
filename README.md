<div align="center">
  <h1>Hermes</h1>
</div>
<div align="center">
  <p><strong>API backend for Prophet</strong></p>
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-2.4.4-red.svg"/>
  </a>
  <a href="https://rubyonrails.org/">
    <img src="https://img.shields.io/badge/Rails-5.1.5-red.svg"/>
  </a>
  <a href="https://travis-ci.com/DreamChest/Hermes">
    <img src="https://travis-ci.com/DreamChest/Hermes.svg?branch=dev"/>
  </a>
</div>

[1]: https://github.com/DreamChest/Prophet
[2]: https://github.com/DreamChest/Mercury
[3]: https://github.com/DreamChest/Trivia
[4]: https://documenter.getpostman.com/view/3934007/hermes/RVnZhyJS
[5]: https://github.com/DreamChest/Mercury/blob/master/LICENSE

## Quickstart

### Requirements

- Ruby 2.4.x
- Rails 5.1.x
- ImageMagick (or at least MagickCore and MagickWand libs)
- PostgreSQL & libpq

For Ruby installation, RVM (or equivalent) is recommended.

### Installation

To install Hermes, make sure to meet the above requirements and get the current stable release with:

```
$ git clone https://github.com/DreamChest/Hermes
$ cd Hermes
$ bundle install
```

Alternatively, instead of cloning the repository, you can download the latest release for the releases pages.

### Configuration

#### Database config

You need to place your database config at **config/database.yml**, a sample config file is located at **config/database.example.yml**.

The example config file assumes the UNIX user running Hermes is associated with a Postgres user/role and has the permission to create databases.

You can then setup the database with `RAILS_ENV=production rake db:setup`.

#### Secrets config

To run Hermes you need to generate an encrypted secrets file with `rails secrets:setup` and then edit the encrypted file with `rails secrets:edit`. The file should at least contain:

```
production:
  secret_key_base: <key>
```

Replace *<key\>* with a secret key which can be generated with `rake secret`.

#### User management

To use Hermes, you will need at least one user, which you can create with `RAILS_ENV=production rake "user:create[email,password]"`.

### Usage

You can start Hermes with `rails server -e production` or `rails server -e production -d` to run in the background.

## Update

TBD

## API Documentation

Full API documentation can be found [here][4].

## Code documentation

Code documentation can be generated by running `yard`. The output documentation will be located at **doc**. You can also use `yard server` to view it directly in your browser.

## Development and contributions

If you want to contribute code to this project, please follow these steps:

- Open a GitHub issue to let us know what you are working on
- Fork the project
- Make sure the dev branch of your fork is up to date with ours
- Create a new branch on your fork, based on the dev branch
- Once your work is done, make sure your dev branch is still up to date and merge your changes on it
- Open a pull a request to this repository contributions branch

## Bugs

If you find any bugs or issues with Hermes, you can submit an issue. Any issue suggesting features or improvements are also welcome!

## License

[See LICENSE][5].
