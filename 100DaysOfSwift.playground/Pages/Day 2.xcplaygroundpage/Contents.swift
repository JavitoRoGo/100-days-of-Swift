// 100 days of Swift

// MARK: - Day 2: Complex types

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"
let beatles = [john, paul, george, ringo]
// esto es un array, sirve para almacenar datos del mismo tipo; es una colección ordenada de elementos cuyo valor se puede repetir, pero siempre estarán en la misma posición. El tipo del propio array va entre []. Para acceder a un valor se pone su índice entre [] contando desde 0. Para el segundo dato sería:
beatles[1] // devuelve "Paul McCartney"
// Por lo visto se puede crear un array con diferentes tipos de datos, simplemente indicando que será de tipo Any:
let beatlesAny: [Any] = ["John", "Paul", "George", "Ringo", 4, true]

// Set es una colección no ordenada de elementos, que además deben ser únicos y no se pueden repetir. No se almacenan en ningún orden concreto, están desordenados, por lo que no podemos extraer valores con su índice.
let colors = Set(["red", "green", "blue"]) // creación de set a partir de un array
let colors2 = Set(["red", "green", "blue", "red", "blue"]) // los valores repetidos los ignora
colors.contains("yellow") // false

/* Tuples permiten almacenar valores de diferentes tipos, como String, Int y Bool, en un orden concreto. Si se crea con var podemos cambiar el valor de cada dato, pero no podemos cambiar su tipo. Y tampoco se pueden añadir o borrar datos: si creamos un tuple con 3 valores, ya siempre tendrá 3 valores. Al ser una colección ordenada, se puede acceder al valor por su índice o por su nombre (si lo creamos).
 Los tuples se crean con los datos entre () */
var name = (first: "Taylor", last: "Swift") // tuple con nombre para las posiciones
var person = (name: "Paul", age: 40, isMarried: true) // tuple con diferentes tipos de datos

// Dictionaries almacenan valores no ordenados asociados a una clave, que se usa luego para llamar a ese valor: sistema key: value
let heights = ["Taylor Swift": 1.78, "Ed Sheeran": 1.73]
// La inferencia de tipo sería [String: Double]
// Si accedemos a una clave que no existe swift nos devuelve nil. Esto puede solucionarse definiendo un valor por defecto de la siguiente forma:
let favoriteIceCream = ["Paul": "Chocolate", "Sophie": "Vanilla"]
favoriteIceCream["Charlote"] // devuelve nil
favoriteIceCream["Charlote", default: "Unknown"]

var teams = [String: String]() // dictionary vacío
teams["Paul"] = "Red" // forma de añadir valores
var results1 = [Int]() // array vacío. También se puede así: var results1: [Int] = []
var words = Set<String>() // set vacío, en este caso es algo diferente

// Los enum son agrupaciones de valores relacionados, aunque creo que más bien son un tipo de dato, incluso se nombran con mayúscula
enum Result {
    case success
    case failure
}
let result = Result.failure
// Los enum permiten almacenar valores asociados y por tanto ser más preciso o aportar más información:
enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}
let talking = Activity.talking(topic: "football")
// En el siguiente ejemplo se usan los valores del enum dentro de switch para precisar más la respuesta de la función (también hay opcionales):
enum WeatherType {
    case sun
    case cloud
    case windy(speed: Int)
    case rainy(chance: Int, amount: Int) // puede haber varios valores
    case snow
}
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .windy(let speed) where speed < 10: // se ejecuta este case si speed<10
        return "meh"
    case .cloud, .windy: // se usa de nuevo el casse .windy pero sin valor
        return "dislike"
    case .rainy, .snow:
        return "hate"
    }
}
getHaterStatus(weather: .windy(speed: 5))
// También pueden tener un rawvalue, aunque de momento no veo para qué
enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}
let earth = Planet(rawValue: 2)
// que la Tierra sea el dos no parece lógico (rawvalue empieza en 0 pero Tierra es el planeta 3), así que puede hacerse:
enum Planet1: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}
