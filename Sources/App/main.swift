import Vapor

let drop = Droplet()

// Here, we are instantiating a WeatherController object, passing our droplet to its initializer
let weatherController = WeatherController(drop: drop)

// Now, when we create our POST endpoint for "/weather", we can pass it the weather() function from weatherController, which will handle all our logic
drop.post("weather", handler: weatherController.weather)


/// Simple endpoints

// GET /hello
drop.get("hello")
{ req in
    return "Hello, world!"
}

// GET /hello/there
drop.get("hello", "there")
{ req in
    return try JSON(node: ["hello" : "there"])
}

// GET /hi/:name
drop.get("hi", String.self)
{ req, name in
    return "Hi, \(name)"
}

// GET /goodbye?name=value
drop.get("goodbye")
{ req in
    let name = req.data["name"]?.string ?? "you"
    return "Goodbye, \(name)"
}

drop.run()
