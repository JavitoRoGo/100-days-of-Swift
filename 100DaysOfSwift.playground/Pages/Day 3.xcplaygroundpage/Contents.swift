// 100 days of Swift

// MARK: - Day 3: Operadores y condiciones

// Los operadores aritméticos son los clásicos de +, -, * y /. También está % que calcula el resto de una división. Estos operadores se usan entre datos del mismo tipo
let remainder = 13 % 4 // da 1
// Si el resto es 0 es que son múltiplos, pero para eso mejor usamos la propiedad:
let isMultiple = 465.isMultiple(of: 7) // da false
// Los operadores compuestos calculan y asignan a la vez
var score1 = 95
score1 -= 5 // resta 5 y lo asigna a la variable
// Los operadores de comparación devuelven un Bool como resultado: == != < <= > >=. También funcionan con String porque compara el orden alfabético
"Taylor" <= "Swift" // da false

// Los comparadores se usan con if para ejecutar cierto código según cumpla o no la condición: if y else. Incluso puede haber más condiciones con else if
let firstCard = 11
let secondCard = 10
if firstCard + secondCard == 2 {
    print("Aces - lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// Los operadores lógicos se usan para comparar varias condiciones
let age1 = 12
let age2 = 21
if age1 > 18 && age2 > 18 {
    print("Both are over 18")
} // ambas condiciones tienen que ser true para que se ejecute el código
if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
} // basta con que una condición sea true para que se ejecute el código

// El ternary operator usa tres argumentos en una sola línea, y se parece a la fórmula if de excel: condición ? códigoSiTrue : códigoSiFalse
let firstCard1 = 11
let secondCard1 = 10
print(firstCard1 == secondCard1 ? "Cards are the same" : "Cards are different")
// Esta única línea es lo mismo que lo siguiente:
if firstCard1 == secondCard1 {
    print("Cards are the same")
} else {
    print("Cards are different")
}

// Si hay muchas condiciones es más engorroso, y en esos casos se usa mejor la sentencia switch. Tiene que ser exhaustiva, esto es, contemplar todas las posibilidaddes, por lo que se añade un default al final
let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day")
}
// Solo se ejecuta el código del case válido. Si queremos que siga ejecutándose y salte al siguiente se pone fallthrough

// Los operadores de rango se pueden usar en switch pero también en otros sitios: if, array...
let score2 = 85
switch score2 {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
