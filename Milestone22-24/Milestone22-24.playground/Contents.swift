import UIKit

var greeting = "Hello, playground"

// Challenge 1

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.frame.size = CGSize(width: 0.0001, height: 0.0001)
            // alternativa:
            // self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}


// Challenge 2

extension Int {
    func times(_ action: () -> ()) {
        let num: Int
        if self < 0 {
            num = self * -1
        } else {
            num = self
        }
        // alternativa al bucle if
        // guard self > 0 else { return }
        for _ in 1...num {
            action()
        }
    }
}
5.times {
    print("Hello")
}


// Challege 3

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let index = self.firstIndex(of: item) {
            self.remove(at: index)
        }
    }
}
