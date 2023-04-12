// 100 days of Swift

// MARK: - Day 8: Structs

// Los structs son tipos de datos personalizados, con propiedades y métodos. Como son tipos de datos (como Int) se nombran en mayúscula
struct Sport {
    var name: String
} // ejemplo de struct con una propiedad
var tennis = Sport(name: "Tennis") // instancia de tipo Sport, que además es variable:
tennis.name = "Lawn tennis"

// El ejemplo anterior tiene una stored property, pero también hay computed properties, que ejecutan código para saber su valor:
struct Sport1 {
    var name: String
    var isOlympicSport: Bool
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is an Olympic sport"
        } else {
            return "\(name) is not an Olympic sport"
        }
    }
}
let chessBoxing = Sport1(name: "Chessboxing", isOlympicSport: false)
print(chessBoxing.olympicStatus)

// Property observers permiten ejecutar código antes o después que una propiedad cambie. Se hace con didSet, y lo que pasa es que se ejecuta el código que le digamos a didSet cada vez que cambie la propiedad que le digamos
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}
var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 80
progress.amount = 100
// Con willSet se ejecuta el código antes del cambio de la propiedad, pero esto no se usa casi nunca
// Otro ejemplo
struct BankAccount {
    var name: String
    var isMillionnaire = false
    var balance: Int {
        didSet {
            if balance > 1_000_000 {
                isMillionnaire = true
            } else {
                isMillionnaire = false
            }
        }
    }
}

// Un struct puede contener una función, y usar las propiedades internas del struct (sin necesidad de definir parámetros para la función). Estas funciones "internas" se llaman métodos
struct City {
    var population: Int
    func collectTaxes() -> Int {
        return population * 1000
    }
}
let london = City(population: 9_000_000)
london.collectTaxes()
// Otro ejemplo
struct Venue {
    var name: String
    var maximumCapacity: Int
    func makeBooking(for people: Int) {
        if people > maximumCapacity {
            print("Sorry, we can only accommodate \(maximumCapacity)")
        } else {
            print("\(name) is all yours!")
        }
    }
}

// Por defecto Swift no deja crear un método que cambie una propiedad, salvo que específicamente así se lo digamos con mutating
struct Person {
    var name: String
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
var person1 = Person(name: "Ed")
person1.makeAnonymous()
let otherPerson = Person(name: "Pepe")
// otherPerson.makeAnonymous() esto da error porque los mutating, al cambiar una propiedad, solo funcionan con instancias variables
// Otro ejemplo
struct Book {
    var totalPages: Int
    var pagesLeftToRead = 0
    mutating func read(pages: Int) {
        if pages < pagesLeftToRead {
            pagesLeftToRead -= pages
        } else {
            pagesLeftToRead = 0
            print("I'm done!")
        }
    }
}

// El tipo de dato String es internamente un struct, y por lo tanto tiene un montón de propiedades y métodos (¡son muchísimos!). Por ejemplo:
let testString = "Do or do not, there is no try."
print(testString.count)
print(testString.hasPrefix("Do"))
print(testString.uppercased()) // todo en mayúsculas
print(testString.sorted())

// Lo mismo pasa con los arrays
var toys = ["Woody"]
print(toys.count)
toys.append("Buzz")
toys.firstIndex(of: "Buzz") // devuelve el índice, sirve para localizar elementos
print(toys.sorted())
toys.remove(at: 0)
