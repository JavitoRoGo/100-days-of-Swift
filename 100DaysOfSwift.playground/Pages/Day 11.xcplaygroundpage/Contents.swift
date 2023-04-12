// 100 days of Swift

// MARK: - Day 11: Protocols and extensions

// Los protocolos son una forma de decir qué propiedades y métodos debe tener algo
protocol Identifiable {
    var id: String { get set }
}
// esto crea un protocolo que requiere que todos los tipos que lo conforman tengan un id string que puede leerse (get) o escribirse (set)
// No podemos crear instancias de un protocolo, puesto que se trata de una descripción de algo que queremos; pero sí podemos crear un struct que cumpla con el protocolo. O una función:
struct UserProtocol: Identifiable {
    var id: String
}
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
// Un protocolo se usa para definir qué propiedades y métodos debe tener algo (struct, class, enum); creamos el protocolo con las características que queremos y lo usamos luego para "conformar" todo lo que necesitemos. El protocolo es el mínimo que el objeto debe tener, al que luego se le pueden añadir más cosas:
protocol Purchaseable {
    var name: String { get set }
}
struct newBook: Purchaseable {
    var name: String
    var author: String
}
struct newMovie: Purchaseable {
    var name: String
    var actors: [String]
}
func buy(_ item: Purchaseable) {
    print("I'm buying \(item.name)")
}

// Los protocolos pueden inferirse desde otro protocolo del que heredan sus características, pero a diferencia de las clases se pueden inferir de varios protocolos a la vez:
protocol Payable {
    func calculateWages() -> Int
    // en el protocol la función se define tal cual así, sin el cuerpo
}
protocol NeedsTraining {
    func study()
}
protocol HasVacation {
    func takeVacation(days: Int)
}
// Ahora creamos uno que incluya a los tres, y como no vamos a añadir nada más, pues basta con las llaves
protocol Employee: Payable, NeedsTraining, HasVacation { }
// Otro ejemplo:
protocol HasRooms {
    var roomCount: Int { get set }
}
protocol ServesFood {
    var openingTime: Int { get set}
}
protocol Hotel: HasRooms, ServesFood {
    var starRating: Int { get set }
}

// Las extensiones permiten añadir métodos nuevos a los tipos existentes. Por ejemplo, añadir una extensión al tipo Int para que calcule lso cuadrados:
extension Int {
    func squared() -> Int {
        return self * self
    }
}
let number = 8
number.squared()
// Otro ejemplo es un método para Int que devuelva true para números pares. En las extensiones no podemos crear stored properties, sino computed properties:
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
// Otro más:
extension String {
    func withPrefix(_ prefix: String) -> String {
        if self.hasPrefix(prefix) { return self }
        return "\(prefix)\(self)"
    }
}

// Los protocolos permiten describir los métodos que algo tendrá, pero no especifica el código en su interior. Las extensiones nos dan el código de los métodos, pero solo afectan a un tipo de dato. Protocol extension resuelve esta situación: detallan el código del método y se hacen extensibles a todos los conforming types:
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name)
        }
    }
}
pythons.summarize()
beatles.summarize()
// Otro ejemplo
protocol Politician {
    var isDirty: Bool { get set }
    func takeBribe()
}
extension Politician {
    func takeBribe() {
        if isDirty {
            print("Thank you ver much!")
        } else {
            print("Someone call the police")
        }
    }
}

// Las extensiones de protocolos nos dan implementaciones por defecto para nuestros métodos de los protocolos. Por ejemplo, creamos un protocol con un método, que podría detallarse en cada tipo que conformemos; pero la extensión nos permite asignarle una acción por defecto:
protocol Identifiable1 {
    var id: String { get set }
    func identify()
}
extension Identifiable1 {
    func identify() {
        print("My ID is \(id).")
    }
}
struct User: Identifiable1 {
    var id: String
}
let twostraws = User(id: "twostraws")
twostraws.identify()
