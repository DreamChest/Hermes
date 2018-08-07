# Hermes

Hermes is the backend API for [Prophet][1]. For the front-end, see [Mercury][2]. For the mobile app see [Trivia][3].

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

`$ git clone https://github.com/DreamChest/Hermes && cd Hermes`

### Configuration

#### Database config

You need to place your database config at **config/database.yml**, a sample config file is located at **config/database.example.yml**.

You can then setup the database with `RAILS_ENV=production rake db:setup`.

#### Secrets config

To run Hermes you need to generate an encrypted secrets file with `rails secrets:setup` and then edit the encrypted file with `rails secrets:edit`. The file should at least contain:

```
production:
  secret_key_base: <key>
```

Replace *<key\>* with a secret key which can be generated with `rake secret`.

#### User management

tbd

### Usage

You can start Hermes with `rails server -e production`.

## API Documentation

Full API documentation can be found [here][4].

## Development and contributions

To contribute to Hermes, you can fork the project and work on your own features.

Development requirements are the same as described in the [requirement section](#requirements).

Installation instructions are Rails classic procedure :

-   Fetch the code (from your fork)
-   cd into the project directory
-   Run `bundle install`
-   Migrate the database with `rake db:migrate`
-   Start the development server with `rails s`
-   Database can be populated with `rake db:seed`

All developements should be placed into one or several branch(es) based on the **dev** branch. Once your changes are done, you can submit a pull request.

If you simply want to suggest a feature, you are also welcome to submit an issue.

## Bugs

If you find any bugs or issues with Hermes, you can submit an issue.

## License

[See LICENSE][5].
