// 100 days of Swift

// MARK: - Day 7: Closures II

// Los closures también pueden aceptar parámetros igual que una función, ya sea por ellos mismos o dentro de una función al introducirlos como parámetros. Veamos una función cuyo único parámetro es un closure que a su vez acepta un parámetro:
let drivingWithParameter = { (place: String) in
    print("I'm going to \(place) in my car")
}
func travelWithClosureWithParameter(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("Rome") // este sería el closure con un parámetro
    print("I arrived!")
}
travelWithClosureWithParameter { (place: String) in
    print("I'm going to \(place) in my car")
    drivingWithParameter("Viena") // esto también sería válido, usando el closure creado antes
}
// Definir un closure como parámetro de una función lo que permite es introducir en la función otra acción, que puede ser un closure o escribir el código de esa acción como en los ejemplos

// Función de parámetro único de tipo closure, y el closure acepta un parámetro y devuelve un valor:
func travelWithClosureWithReturn(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("Madrid")
    print(description)
    print("I arrived!")
}
travelWithClosureWithReturn { (place: String) -> String in
    return "I'm going to \(place) in my car" // al ser una sola línea se puede omitir return
}
// Otro ejemplo
func encrypt(password: String, using algorithm: (String) -> String) {
    print("Encrypting password...")
    let result = algorithm(password)
    print("The result is \(result)")
}
encrypt(password: "t4ylor") { (password: String) in
    print("Using top secret encryption!")
    return "SECRET" + password + "SECRET"
} // las acciones descritas al llamar la función se pueden sustituir por un closure que ya estuviese definido

// Más cosas de los closures: closure con dos parámetros y retorno como parámetro de función
func travelWithTwoParameters(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("Berlin", 60)
    print(description)
    print("I arrived!")
}
travelWithTwoParameters { (place: String, speed: Int) -> String in
    return "I'm going to \(place) at \(speed) miles per hour."
}
// Lo anterior también puede escribirse como sigue, que sería la forma corta porque Swift ya conoce el tipo de los parámetros del closure y del valor de retorno, y por tanto se pueden omitir; y además nos crea un nombre de parámetro con $ y su posición:
travelWithTwoParameters {
    "I'm going to \($0) at \($1) miles per hour."
}
// Otros ejemplos
func playSong(instrumentClosure: (String, Int) -> Void) {
    let song = "Stairway to heaven"
    let volume = 11
    print("I'm going to play \(song)...")
    instrumentClosure(song, volume)
}
func authenticate(algorithm: (String, String) -> Bool) {
    print("Authenticating user")
    let username = "twostraws"
    let password = "fr0sties"
    let result = algorithm(username, password)
    if result {
        print("You're in!")
    } else {
        print("Try again.")
    }
}

// Y más difícil todavía: un closure puede ser el valor de retorno de una función. El ejemplo crea un función sin parámetros pero que devuelve un closure, éste sin valor de retorno:
func travelWithClosureAsReturnValue() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}
let result2 = travelWithClosureAsReturnValue() // llamamos a la función creada, y la asignamos a una constante pues lo que devuelve es un closure
result2("London") // llamamos al closure de retorno que se crea como se llama por defecto a un closure (sin nombre de parámetro)
// Más ejemplos
func createValidator() -> (String) -> Bool {
    return {
        if $0 == "twostraws" {
            return true
        } else {
            return false
        }
    }
}
let validator = createValidator()
print(validator("twostraws")) // devuelve true

func makeRecorder(media: String) -> () -> String {
    switch media {
    case "podcast":
        return {
            return "I'm recording a podcast"
        }
    default:
        return {
            return "I'm recording a video"
        }
    }
}
let recorder = makeRecorder(media: "podcast")
print(recorder())

func createAgeCheck(strict: Bool) -> (Int) -> Bool {
    if strict {
        return {
            if $0 <= 21 {
                return true
            } else {
                return false
            }
        }
    } else {
        return {
            if $0 <= 18 {
                return true
            } else {
                return false
            }
        }
    }
}
let ageCheck = createAgeCheck(strict: true) // crea un closure que es el retorno de la función
let ageResult = ageCheck(20) // crea un Bool que es el retorno del closure (retorno a su vez de la función)
print(ageResult)

// Los closures pueden "capture" valores; esto significa que, si creamos un valor dentro del mismo, seguirá existiendo y estando disponible fuera del mismo. Por ejemplo, creando un contador dentro de la función pero que se usa y actualiza dentro del closure de retorno, y nos dice cuántas veces se llama al closure de retorno (no a la función):
func travelWithCapturinValues() -> (String) -> Void {
    var counter = 1
    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
let result3 = travelWithCapturinValues()
result3("Oslo") // 1
result3("Oslo") // 2
result3("Oslo") // 3
// Capturing values funciona con los valores DENTRO del closure. En este ejemplo anterior, la variable counter se crea una sola vez dentro de la función cuando se la llama, pero se actualiza (y captura) dentro del closure, y cada vez que se llama al closure (y no a la función)
