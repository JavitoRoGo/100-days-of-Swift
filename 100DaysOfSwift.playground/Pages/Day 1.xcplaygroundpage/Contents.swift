// 100 days of Swift

// MARK: - Day 1: Variables and constants

var str = "Hello, playground" // variable de tipo String
str = "Goodbye"
var age = 38 // tipo Int
var population = 8_000_000 // uso de separadores de miles
var str1 = """
This goes
over multiple
lines
"""     // se usan 3 comillas para poner saltos de línea en un String
var str2 = """
This goes \
over one \
line
"""     // al terminar la línea con \ el String está en una sola línea, pero permite varias líneas en código por si queremos claridad al escribirlo
var pi = 3.141 // tipo Double
var awesome = true // tipo Bool

// String interpolation
var score = 85
str = "Your score was \(score)"
var results = "The test results are here: \(str)"
// Se puede hacer infinitas veces, e incluso se puede ejecutar código mediante esta interpolación

let taylor = "swift"    // constante
// Salvo que un valor cambie, siempre será mejor usar constantes. Xcode y Swift nos avisan si creamos var y detecta que ese valor no cambia

// Hasta aquí Swift ha inferido el tipo de dato según lo que está escrito, pero podemos indicar o forzar el tipo de dato
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true
