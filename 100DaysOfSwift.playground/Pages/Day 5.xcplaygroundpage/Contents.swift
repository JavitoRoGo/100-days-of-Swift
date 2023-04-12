// 100 days of Swift

// MARK: - Day 5: Functions

// Las funciones son útiles para ejecutar un bloque de código en diferentes puntos de nuestra app, nos permiten llamarlas para evitar repetir el mismo código en diferentes puntos.
func printHelp() {
    let message = """
    Welcome to MyApp!
    
    Run this app inside a directory of images and
    MyApp will resize them all into thumbnails
    """
    print(message)
}
printHelp()

// Las funciones nos permiten introducir parámetros y así personalizarlas en cada llamada. Para varios parámetros, se separan por coma.
func square(number: Int) {
    print(number * number)
}
square(number: 8)

// También nos devuelven uno o varios valores, indicados mediante return.
func square1(number: Int) -> Int {
    return number * number
}
let result1 = square1(number: 8)
print(result1)

// Los parámetros de la función pueden tener nombre: uno externo que se muestra al llamarla, y otro interno que se usa en el código. Esto nos sirve para que las funciones sean más legibles, ya que al definirlas debe poder leerse como en una frase lo que hacen, para mayor legibilidad del código.
func sayHello(to name: String) {
    print("Helle, \(name)!")
}
sayHello(to: "Taylor")

// El nombre externo se puede omitir usando _
func greet(_ person: String){
    print("Hello, \(person)!")
}
greet("Taylor")
// Se suele usar esto (omitir el nombre externo del parámetro) cuando el nombre de la función es un verbo y el nombre del parámetro es un sustantivo

// Los parámetros pueden tener valores asignados por defecto, que podremos cambiar aun así si nos interesa
func greet1(_ person: String, nicely: Bool = true) {
    if nicely == true {
        print("Hello, \(person)!")
    } else {
        print("Oh no, it's \(person) again...")
    }
}
greet1("Taylor") // no se especifica el parámetro nicely porque ya tiene un valor por defecto
greet1("Taylor", nicely: false) // en esta línea hemos cambiado el valor por defecto que tenía el parámetro nicely

// Una función variadic (no sé la traducción) puede aceptar múltiples parámetros, sin especificar su número, pero siempre del mismo tipo. Se define con ... después del tipo del parámetro. Al llamarla los parámetros se separan con comas
func squareVariadic(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
squareVariadic(numbers: 1, 2, 3, 4, 5)
// Internamente, estos variadic parameters se comportan como un array: podemos recorrerlos con for, llamarlos por su índice, etc.

// Throwing functions nos permiten sacar o tirar un error si algo (que definimos nosotros) va mal dentro de la función. Lo primero es definir un enum con los tipos predeterminados de error que queremos
enum PasswordError: Error {
    case obvious // el nombre lo elegimos nosotros
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
// checkPassword("hola")
// No se puede llamar a una throwing function como las demás porque puede dar el error que hemos definido, y a Swift no le gustan los errores. En estos casos se hace de la siguiente forma, con las palabras reservadas do, try y catch:
    // do incluye una sección de código que puede dar problemas
    // try va antes de la función a probar que puede dar error. Si da el error salta directamente a catch
    // catch permite gestionar el error
do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// Los parámetros se crean como constantes, pero si queremos cambiar su valor en el sitio en lugar de crear uno nuevo se hace con inout. Aunque lo primero sería crear una variable que usaremos como parámetro e introducirla en la función con &
func doubleInPlace(number: inout Int) {
    number *= 2
}
var myNum = 3
doubleInPlace(number: &myNum)
