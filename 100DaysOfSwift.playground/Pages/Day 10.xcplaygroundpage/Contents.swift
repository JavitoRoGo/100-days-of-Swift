// 100 days of Swift

//MARK: - Day 10: Classes

// Las clases son similares a structs: permiten crear nuevos tipos con propiedades y métodos, pero hay 5 diferencias fundamentales. La primera es que una clase no posee un memberwise initializer: si tenemos propiedades en la clase siempre hay que crear un init:
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
// Las instancias de la clase se crean igual que para structs
let poppy = Dog(name: "Poppy", breed: "Poodle")

// La segunda diferencia es que se puede crear una clase basada en otra existente, que heredará sus propiedades y métodos, permitiendo crear otros on top. Esto es la herencia, class inheritance o subclassing: la clase inicial se llama parent o super, y la nueva se llama child class:
// Creación de una clase a partir de la anterior Dog. Esta nueva clase puede tener su propio init, que sea para la propiedad name porque breed será siempre poodle. Es más, incluso puede usar el init de la clase super Dog:
class Poodle: Dog {
    init(name: String) { // init de clase Poodle
        super.init(name: name, breed: "Poodle") // llamada al init de la clase original o super class
    }
}
// Otro ejemplo:
class Instrument {
    var name: String
    init(name: String) {
        self.name = name
    }
}
class Piano: Instrument {
    var isElectric: Bool
    init(isElectric: Bool) {
        self.isElectric = isElectric
        super.init(name: "Piano")
    }
}
// Otro ejemplo:
class Printer {
    var cost: Int
    init(cost: Int) {
        self.cost = cost
    }
}
class LaserPrinter: Printer {
    var model: String
    init(model: String, cost: Int) {
        self.model = model
        super.init(cost: cost)
    }
}

// Las child classes pueden añadir sus propias implementaciones a los métodos heredados; esto se conoce como overriding: es modificar un método heredado de la clase super:
class Dog1 {
    func makeNoise() {
        print("Woof!")
    }
}
class Poodle1: Dog1 {
    override func makeNoise() {
        print("Yip!")
    }
}
let poppy1 = Poodle1()
poppy1.makeNoise() // este método ahora imprime Yip en lugar de Woof
// Otro ejemplo
class Band {
    func singSong() {
        print("Here's a new song")
    }
}
class MetalBand: Band {
    override func singSong() {
        print("Ruuuuh ruh ruh ruuuuuh!")
    }
}
let lordi = MetalBand()
lordi.singSong()

// A pesar de las ventajas de la herencia, si nos interesa en un momento dado podemos hacer que no se pueda hacer esta herencia a otras clases, y por tanto que no se pueda hacer overriding y modificar un comportamiento. Simplemente no deja hacer la herencia:
final class DogWithFinal {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// La tercera diferencia con los structs está en cómo se hacen las copias de los objetos: mientras que con un struct el original y la copia son cosas diferentes (cambiar uno no cambia el otro), el original de la clase y su copia apuntan al mismo sitio, por lo que cambiar uno cambia al otro:
class Singer {
    var name = "Taylor Swift"
}
var singer = Singer()
print(singer.name) // devuelve "Taylor Swift"
var singerCopy = singer // copia de singer a singerCopy
singerCopy.name = "Justin Bieber"
print(singer.name) // ahora devuelve "Justin Bieber" porque ambas copias apuntan al mismo name de la clase
// En cambio, si Singer fuese un struct en el segundo print seguiríamos teniendo "Taylor Swift", porque original y copia son cosas diferentes
// Structs are value types while classes are reference types

// La cuarta diferencia está en que las clases pueden tener deinitializers. Un ¿desiniciador? es un código que se ejecuta cuando una instancia de una clase es destruida:
class PersonDeinit {
    var name = "John Doe"
    init() {
        print("\(name) is alive!")
    }
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    deinit {
        print("\(name) is no more!")
    }
}
for _ in 1...3 {
    let person = PersonDeinit()
    person.printGreeting()
} // con el bucle for se crea y se destruye un person en cada iteración, y así se imprime el deinit

// La diferencia final entre struct y class está en la mutabilidad. Esto significa que un struct constante (la instancia) no se puede cambiar aunque tenga una propiedad variable; y para que un método cambie una propiedad hay que especificarlo con mutating. Sin embargo, en las clases no necesitamos escribir mutating porque por defecto se pueden cambia, incluso con instancias creadas como let. Por ejemplo, usando la clase Singer creada antes:
let taylorS = Singer()
taylorS.name = "Ed Sheeran"
// se puede cambiar la propiedad name a pesar de que la instancia taylorS se creó con let. Para evitar esto, que se pueda cambiar una propiedad, habría que crearla como let dentro de la propia clase
