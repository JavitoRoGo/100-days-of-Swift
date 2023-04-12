// 100 days of Swift

// MARK: - Day 13 to 15

// Son 3 días de repaso y consolidación de conceptos. Lo visto estos días complementa los apuntes de cada día

import UIKit
var fecha = Date()
let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "mm:ss"
    return formatter
}()

print(formatter.string(from: fecha))


let date1 = "02:45"
let date2 = formatter.date(from: date1)
print(date2!)


var tempArray = [String]()
for char in date1 {
    tempArray.append(String(char))
}
var min = Double(tempArray[0] + tempArray[1])
var seg = Double(tempArray[3] + tempArray[4])
print(min! + seg!/60)



var kkk: Double = 1.58712
let segs = ((kkk.truncatingRemainder(dividingBy: 1))*60).rounded()
let mins = kkk - kkk.truncatingRemainder(dividingBy: 1)

var hhh: Double = 88.39601
let hours = hhh - hhh.truncatingRemainder(dividingBy: 1)
let minss = hhh.truncatingRemainder(dividingBy: 1)
