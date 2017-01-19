//
//  WeatherController.swift
//  Weather
//
//  Created by Keli'i Martin on 1/18/17.
//
//

import Foundation
import Vapor
import HTTP

final class WeatherController
{
    var drop: Droplet
    let baseURI = "http://api.openweathermap.org/data/2.5"
    let baseIconURI = "http://openweathermap.org/img/w"

    init(drop: Droplet)
    {
        self.drop = drop
    }

    func weather(request: Request) throws -> ResponseRepresentable
    {
        guard let apikey = self.drop.config["app", "openweathermap-key"]?.string else
        {
            return "No valid API key"
        }

        guard let text = request.data["text"]?.string else
        {
            return "Enter a zip code"
        }

        do
        {
            let apiResponse = try self.drop.client.get("\(baseURI)/weather", query: ["zip" : "\(text),us", "appid" : apikey, "units" : "imperial"])

            var weatherDescription: String?
            var weatherIcon: String?

            let temperature = apiResponse.json?["main", "temp"]?.double ?? 0.0
            let humidity = apiResponse.json?["main", "humidity"]?.double ?? 0.0
            if let weather = apiResponse.json?["weather"]?.pathIndexableArray
            {
                weatherDescription = weather.first?["description"]?.string ?? ""
                weatherIcon = weather.first?["icon"]?.string ?? ""
            }

            let cityName = apiResponse.json?["name"]?.string ?? ""

            let attachment = try JSON(node:
                [
                    "title" : "Current weather for \(cityName) (\(text))",
                    "text" : "\(Int(temperature.rounded()))º F, \(Int(humidity.rounded()))% humidity, \(weatherDescription!)",
                    "thumb_url" : "\(baseIconURI)/\(weatherIcon!).png",
                    "footer" : "Powered by <http://openweathermap.org/|OpenWeatherMap>"
                ])

            let payload = try JSON(node:
                [
                    "response_type" : "in_channel",
                    "attachments" : JSON([attachment])
                ])

            return payload
        }
        catch
        {
            return "\(error.localizedDescription)"
        }
    }
}
