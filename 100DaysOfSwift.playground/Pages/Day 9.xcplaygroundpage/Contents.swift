// 100 days of Swift

// MARK: - Day 9: More structs

// Los inicializadores permiten crear los structs de diferentes formas, asignando valores a las propiedades. Por defecto, los structs incluyen un inicializador que se llama memberwise initializer, que nos obligaría al asignar un valor de parámetro al crear la instancia del struct:
struct User {
    var username: String
}
var user = User(username: "twostraws")
// al crear la instancia del struct nos obliga a asignar un valor a username porque no está definido dentro del struct
// Pero podemos usar init (que es como una función) y hacer que los nuevos usuarios tengan un valor determinado y se ejecute un código (por ejemplo)
struct UserWithInit {
    var username: String
    init() {
        username = "Anonymous"
        print("Creating new user!")
    } // antes del fin de init todas las propiedades deben tener un valor. Es decir, el init debe incluir todas aquellas propiedades que no tengan un valor asignado
}
var newUser = UserWithInit()
// ahora sí permite crear la instancia sin asignar valor al property porque ya lo hicimos con init. Pero se puede cambiar siempre que sea var:
newUser.username = "twostraws"
//var otherUser = UserWithInit(username: "Otro") // esta línea da error porque al crear nosotros un init, éste reemplaza al memberwise init (que es el que permite asignar un valor de parámetro al instanciar el struct), y nuestro init no acepta parámetros
// Si queremos crear un init y a la vez conservar el de defecto, hay que crear el init como una extensión del struct, así:
struct Employee {
    var name: String
    var yearsActive = 0
}
extension Employee {
    init() {
        self.name = "Anonymous"
        print("Creating an anonymous employee...")
    }
}
// de esta forma funcionarían las dos maneras vistas hasta ahora de crear una instancia:
let roslin = Employee(name: "Laura Roslin")
let anon = Employee()
// Otro ejemplo (con dos parámetros para el init):
struct Cabinet {
    var height: Double
    var width: Double
    var area: Double
    init(itemHeight: Double, itemWidth: Double) {
        height = itemHeight
        width = itemWidth
        area = height * width
    }
}
let drawers = Cabinet(itemHeight: 1.4, itemWidth: 1.0)

// La constante especial self apunta a cualquier instancia del struct que se esté usando. Es especialmente útil cuando una propiedad tiene el mismo nombre que un parámentro del init (por ejemplo name). En este caso, self.name se refiere a la propiedad, y name al parámetro:
struct PersonWithSelf {
    var name: String
    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}

// Swift permite crear propiedades solo cuando se necesitan: son las lazy properties, y para que se generen hay que acceder a ellas al menos una vez. Se crean usando la keyword lazy. En este ejemplo además se ve cómo usar un struct como propiedad de otro:
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}
struct PersonWithLazy {
    var name: String
    lazy var familyTree = FamilyTree()
    init(name: String) {
        self.name = name
    }
}
var ed = PersonWithLazy(name: "Ed")
// crea la instancia ed pero no imprime el mensaje
ed.familyTree // al acceder a la propiedad ya se crea el struct FamilyTree y se imprime el mensaje que contiene

// Hasta ahora hemos creado propiedades y métodos que pertenecen a cada instancia del struct. Con static properties podemos pedir a Swift que comparta propiedades y métodos con todas las instancias del struct
struct Student {
    static var classSize = 0
    var name: String
    init(name: String) {
        self.name = name
        Student.classSize += 1
    } // suma 1 cada vez que se crea una instancia (cada vez que se ejecuta el init)
}
print(Student.classSize) // 0
let ned = Student(name: "Ned")
print(Student.classSize) // 1
let fred = Student(name: "Fred")
print(Student.classSize) // 2
// con static lo que hacemos es que esa propiedad pertenezca al propio struct y almacene su valor, por lo que podemos acceder a él directamente en cualquier punto (como en el ejemplo anterior de print). Si no usamos static, tendríamos que instanciar el struct (crear un let o var) y luego llamar a esa propiedad
// Otro ejemplo
struct LegoBrick {
    static var numberMade = 0
    var shape: String
    var color: String
    init(shape: String, color: String) {
        self.shape = shape
        self.color = color
        LegoBrick.numberMade += 1
    }
}

// Access control permite controlar qué propiedades y métodos pueden verse solo dentro del struct:
struct PersonWithControl {
    private var id: String
    init(id: String) {
        self.id = id
    }
}
let mike = PersonWithControl(id: "12345")
// si buscamos la propiedad mike.id veremos que no existe, no aparece. Con private, ahora id solo puede verse y usarse dentro del struct
