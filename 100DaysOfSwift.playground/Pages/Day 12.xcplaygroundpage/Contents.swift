// 100 days of Swift

// MARK: - Day 12: Optionals

// Los opcionales se usan cuando no sabemos el valor que tendrá algo, y pueden contener cualquier valor o ninguno, representado por nil. Se pueden crear opcionales de cualquier tipo de dato. Representan la ausencia de un valor.
var age: Int? = nil
age = 38

// El desempaquetado de un opcional es básicamente mirar en su interior para ver qué hay. Una forma de hacerlo es con una condición usando if let
var name: String? = nil
//name.count // esto da error porque al ser opcional no se sabe si hay algo o no, hay que unwrap
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name")
}
// si name tiene un string entonces se almacena en el string unwrapped y se puede leer la propiedad .count; y si no tiene valor pues se ejecuta el else
// if let nos permite a la vez comprobar si hay valor y extraerlo para usarlo al asignarlo a una constante nueva del mismo tipo pero no opcional
func getUsername() -> String? {
    "Taylor"
}
if let username = getUsername() {
    print("Username is \(username)")
} else {
    print("No username")
}

// También se puede unwrap con guard let, y la diferencia está en que si el valor es nil entonces se espera que nos salgamos de la función o ciclo; y además se puede usar el valor del opcional desempaquetado después del guard let. Con guard let podemos lidiar con el problema al principio de la función y luego salir; y el resto sería la parte segura a ejecutar:
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    print("Hello, \(unwrapped)")
}
// Un ejemplo para imprimir una función que devuelve un Int? con if let y guard let:
func getMeaningOfLife() -> Int? {
    42
}
func printMeaningOfLife() {
    if let name = getMeaningOfLife() {
        print(name)
    }
}
func otherPrintMeaningOfLife() {
    guard let name = getMeaningOfLife() else {
        return
    }
    print(name)
}

// El desempaquetado se puede forzar con el símbolo !, pero solo puede hacerse cuando estamos seguros que habrá un valor porque si no el código fallará
let str = "5" // String
let num = Int(str) // Int? opcional porque puede no haber valor convertible a Int
let numUnwrapped = Int(str)! // Int, ya está desempaquetado. Si cambiamos str por una letra el código falla

// Los opcionales implícitamente desempaquetados (inplicitly unwrapped optionals) se definen con ! en lugar de ?, e igualmente puden contener un valor o ser nil. La diferencia está en que pueden utilizarse directamente como si estuviesen ya desempaquetados, sin tener que usar if let o guard let para desempaquetarlos. Ahora bien, si son nil el codigo fallará, por lo que hay que usarlos con cuidado y solo cuando sepamos al 100% que tendrán un valor
let ageOptional: Int! = nil

// El operador nil coalescing despempaqueta un opcional y devuelve su valor en caso de tenerlo; si el opcional es nil se devuelve un valor por defecto:
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}
let user = username(for: 15) ?? "anonymous"
// esta línea comprueba el resultado devuelto por la función username: si es un String entoncess lo asigna a user; si es nil asigna el valor por defecto que hemos definido
// La ventaja del nil coalescing operator es que desempaqueta el opcional o nos devuelve un valor por defecto para nil

// Optional chaining es como un atajo cuando usamos a.b.c, varias propiedades a la vez; si alguna es nil entonces se ignora toda la línea y se devuelve nil, pero si tiene un valor se continua con la operación:
let names = ["John", "Paul", "George", "Ringo"]
let beatle = names.first?.uppercased() // este signo ? es optional chaining: si la propiedad .first (primer valor de la colección) es nil devuelve nil, pero si tiene un valor sigue la ejecución y lo devuelve en mayúsculas
// Otro ejemplo, combinado en este caso además con nil coalescing
let moreNames = ["Vincent": "van Gogh", "Pablo": "Picasso", "Claude": "Monet"]
let surnameLetter = moreNames["Claude"]?.first?.uppercased() ?? "?"

// Existe el opcional try para probar funciones que devuelvan throw y lancen un error. En la lección de esas funciones vimos:
enum PasswordError: Error {
    case obvious
}
func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    return true
}
do {
    try checkPassword("password")
    print("That password is good")
} catch {
    print("You can't use that password")
}
// Tenemos dos altrenativas. La primera es try? que cambia throwing function en funciones que devuelven un opcional (nil en caso de error)
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh")
}
// La otra alternativa es con try! pero solo puede usarse si tenemos certeza que dará un valor (no nil)
try! checkPassword("sekrit")

// También un inicializador o init puede ser opcional, de forma que puede funcionar o no, devolviendo nil en este último caso. El ejemplo crea un struct en el que el id tiene que tener 9 caracteres o devolverá nil
struct Person {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
// Otro ejemplo con dos checks:
struct Employee {
    var username: String
    var password: String
    
    init?(username: String, password: String) {
        guard password.count >= 8 else { return nil }
        guard password.lowercased() != "password" else { return nil }
        
        self.username = username
        self.password = password
    }
}
let tim = Employee(username: "TimC", password: "app1e")
let craig = Employee(username: "CraigF", password: "ha1rf0rce0ne")

// Typecasting es como una comprobación que hace Swift del tipo de los elementos de una colección. En este ejemplo se crean tres clases, y luego dos de ellas se usan para crear un array. Por inferencia el array será de tipo Animal. Si queremos un loop del array que haga que los de tipo perro ladren, es cuando usamos el typecasting: se creará un opcional nil si no es un perro, y un opcional convertible si es tipo perro:
class Animal { }
class Fish: Animal { }
class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
// En este otro ejemplo se crea una clase con una propiedad (con valor por defecto para no poner init), y dos más por herencia con una propiedad más cada una, por lo que la propiedad de la super class es compartida por las dos child classes. Luego instanciamos estas dos child y creamos un array que Swift entiende que es del tipo común (la super classs). Creamos un bucle for con typecasting para poder acceder a las propiedades adicionales de las child classes:
class Person1 {
    var name = "Anonymous"
}
class Customer: Person1 {
    var id = 12345
}
class Employee1: Person1 {
    var salary = 50_000
}
let customer = Customer()
let employee = Employee1()
let people = [customer, employee]
for person in people {
    if let customer = person as? Customer {
        print("I'm a customer, with id \(customer.id)")
    } else if let employee = person as? Employee1 {
        print("I'm an employee, earning $\(employee.salary)")
    }
}
// Otro ejemplo:
class CitrusFruit {
    var averagePH = 3.0
}
class Orange: CitrusFruit { }
let citrus = Orange()
if let orange = citrus as? Orange {
    print("This orange has a pH of \(orange.averagePH)")
}
