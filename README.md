# Hermes

Hermes is the backend API for the new version of Prophet RSS reader. For the front-end, see [Mercury][1].

**Disclaimer**: Hermes (and all components of the new version of Prophet) is still under heavy development and the ["classical" version][2] of Prophet is still considered to be the stable, production-ready version.

[1]: https://github.com/DreamChest/Mercury
[2]: https://github.com/DreamChest/Prophet
[3]: https://github.com/DreamChest/Prophet-Mobile
[4]: https://documenter.getpostman.com/view/3934007/hermes/RVnZhyJS
[5]: https://github.com/DreamChest/Mercury/blob/master/LICENSE

## Requirements

-   Ruby 2.2+
-   Rails 5.1+
-   ImageMagick (or at least MagickCore and MagickWand libs)

## Installation

To install Hermes, make sure to meet the above requirements and get the current stable release with :

`$ git clone https://github.com/DreamChest/Hermes && cd Hermes`

Then you have to generate a secret key, install the project Gems and migrate the database, which can all be done by running `./scripts/install.sh`.

More installation options coming soon.

## Configuration

For now, the only needed configuration for the API is the creation a user, you can create one by running `rake user:create\[email,password\]`, replacing email by an email and password by the wanted password.

## Usage

You can run the server simply by using `./scripts/run.sh --run`. This script also offers the *--stop* and *--restart* options.

Once Hermes is up, you should be able to send it requests and configure either [Mercury][1] or [Prophet-Mobile][3] to connect to it.

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
