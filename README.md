# RailsLifts
A Rails Based Workout Creator and Tracker

# Introduction

RailsLifts is a simple Rails based app that allows users to sign into their personal user account and track the progress of their individual workouts. This is done by either creating or selecting a previously made program, and then entering their personal workout information into the provided workout form. The 'Next Workout' form will display the user's previous stats for that particular workout, giving him/her a target to hit and surpass.

If a user finds that specific exercises or workouts are missing, they are free to create their own. These then become available for use by other users.

This project is part of <a href="http://learn.co">FlatIron's Learn-Verified</a> curriculum.

# Installation

Assuming `git` is installed:<br />
1.) Fork or clone this repo: `git clone https://github.com/dukeoflaser/RailsLifts`<br />
2.) From your command line, navigate to the `RailsLifts` directory.<br />
3.) run `bundle install`. If bundler is not already installed, install it with `gem install bundler -v 1.12`. (As of the time of this writing, the current version of bundler is 1.13 and has had some issues). Version 1.12 is currently more stable.<br />
4.) Run the migrations to create the database/schema. `rake db:migrate`<br />
5.) Seed the database. `rake db:seed`<br />
6.) Start the rails server. `rails s`<br />
7.) Navigate to `localhost:3000`<br />

*Note: The option to sign-in with facebook is still in testing mode. As such, I am currently the only user able to do so.*



## Contributing

Should you wish to contribute, simply fork this repo, code to your heart's content, and issue a pull request. I will review the changes and, if deemed an improvement, will accept the request.

# License

The MIT License (MIT)

Copyright (c) 2016 Nathaniel Miller


Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
