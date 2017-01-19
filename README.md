# Creating Custom Slack Integrations using Vapor

This demo was part of a talk I gave at the [Orlando iOS Developers Meetup](https://www.meetup.com/Orlando-iOS-Developer-Group/) on [January 18, 2017](https://www.meetup.com/Orlando-iOS-Developer-Group/events/236735269/).  During the presentation, I gave a quick introduction to Vapor, a Swift 3 framework for building web apps.  I also went over some of the basics of using the Slack API to create a custom slash command.  This project is the final result of that demonstration.

### NOTES
- If you want to run this Slack command, you will need to obtain an API Key from [OpenWeatherMap](http://openweathermap.org).  Once you have your API key, you can do one of two things: 
  1. you can create an environment variable called `$OPEN_WEATHER_MAP_KEY` with the value of your API key
  2. you can create a new folder under `Config/` called `secrets`.  In that folder, you will copy the `app.json` file from `Config/` into `Config/secrets`.  Then, you would replace `$OPEN_WEATHER_MAP_KEY` with your actual API key

Presentation slides will be available soon.
