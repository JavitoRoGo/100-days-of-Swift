// 100 days of Swift

// MARK: - Day 4: Loops

// El bucle for se usa para repetir un código un número de veces, o para recorrer los elementos de un rango o un array
let count = 1...10
for number in count {
    print("Number is \(number)")
}
let albums = ["Red", "1989", "Reputation"]
for album in albums {
    print("\(album) is on Apple Music")
}

// El bucle while evalúa una condición al principio, y luego ejecuta el código mientras se cumpla la condición
var number = 1
while number <= 20 {
    print(number)
    number += 1
}
print("Esto se ejecuta cuando termina el bucle while")

// El bucle repeat es igual que while salvo que la condición se evalúa al final, por lo que el código se ejectua al menos una vez
while false {
    print("This is false")
} // este nunca se ejcuta y Xcode nos da un warn
repeat {
    print("This is false")
} while false // este se ejecuta una vez

// Podemos salirnos de un ciclo o bucle usando el comando break
var countDown = 10
while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        print("I'm bored. Let's go now")
        break
    }
    countDown -= 1
}

// Si tenemos un loop dentro de otro se llama nested loop, y si queremos salir de los dos a la vez tenemos que nombrar el loop de fuera y hacer lo siguiente (ejemplo de tablas de multiplicar):
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print("\(i) * \(j) is \(product)")
        
        if product == 50 {
            break outerLoop
        }
    }
}
// Otro ejemplo, en este caso para tratar de acertar una combinación secreta
let options = ["up", "down", "left", "right"]
let secretCombination = ["up", "up", "right"]
outerLoop: for option1 in options {
    for option2 in options {
        for option3 in options {
            print("In loop")
            let attempt = [option1, option2, option3]
            
            if attempt == secretCombination {
                print("The combination is \(attempt)")
                break outerLoop
            }
        }
    }
}

// También se puede saltar un elemento o iteración en lugar de todo el bucle. Para ello se usa el comando continue
for i in 1...10 {
    if i % 2 == 1 { // esta línea hace que los números sean impares
        continue // esta línea hace que no se ejecute el código en la iteración actual y salte a la siguiente
    }
    print(i)
}

// Los loop infinito son bucles que no terminan nunca, a menos que los paremos nosotros con alguna condición. Se hacen con while true, que siempre será true y por tanto se ejecuta siempre y hasta el infinito. OJO: hay que estar seguros que ponemos alguna condición de break o no se pararán nunca
var counter = 0
while true {
    print("Infinite... and so on")
    counter += 1
    if counter == 20 {
        break
    }
}
