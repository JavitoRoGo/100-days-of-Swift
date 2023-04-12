// 100 days of Swift

// MARK: - Day 6: Closures I

// Swift permite trabajar con funciones igual que otro tipo de dato: podemos asignarla a una variable, podemos llamarla usando esa variable, e incluso pasarla como parámetro de otra función. Estas funciones se llaman closures, y se escriben diferente a pesar de ser precisamente eso, funciones
let driving = {
    print("I'm driving in my car")
}
// Esto crea una función sin nombre que se asigna a la constante driving, y se puede llamar a esta función con esa constante
driving()
// Se usan para almacenar una funcionalidad, que rescataremos cuando nos interese

// Los closures aceptan parámentros de entrada y se definen justo después de la llave
let drivingWithParameter = { (place: String) in
    print("I'm going to \(place) in my car")
}
drivingWithParameter("London") // al llamar un closure no se usa el nombre del parámetro. Por tanto, no aceptan un nombre externo para el parámetro

// Y también nos pueden dar un valor de retorno como si de una función se tratase
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
let message = drivingWithReturn("Paris")
print(message)

// Para usar un closure como parámetro de función, ésta debe tener un parámetro (con nombre, incluso interno y externo) sin tipo y que devuelva nada: () -> Void (pero la propia función sí puede tener un valor de retorno, e incluso más parámetros). Es decirle a la función que su parámetro es un closure sin parámetro y que devuelve nada. Por ejemplo, para usar el primer closure creado driving en una función sería:
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}
travel(action: driving)
// Si en una función su último parámetro es un closure se puede usar la llamada trailing closure syntax, donde el parámetro que es el closure se pone directamente entre llaves:
travel {
    driving()
}
