# Protocol

# Property Observer
willSet - didSet

# String Escape

# API availability Checks
@#available(iOS 13, *)

# Computed Property
var area: Double { }
getter setter

# propertyWrapper

# Generics
```
func sortElements<T: Comparable>(_ array: [T]) -> [T] {
    return array.sorted()
}
```

# Key Path
KeyPathComparator, WritableKeyPath, ReferenceWritableKeyPath

# Conditional Conformances
where Element: Printable

# Value vs Reference
value'da tam kopyası oluşur.
inheritence reference de yoktur. class.
deinit reference de yoktur 

# any vs some
some: tür belli, tek bir tür. static dispatch (performanslıdır.) 
any: tür bilinmez sadece protocolu bilir. farklı türler döner. dynamic disppatch (daha az performanslı.)

# KVO Pattern

# Phantom Types
Run-time'a düşmeden derleme zamanında hata çıkartır. Generic parametresi tip ayırtmak için kullanılır. ID, State yönetimi vs.
```
import Foundation

struct ID<T>: Equatable {
    private let value = UUID()
}

struct Person {
    let id = ID<Self>()
    let name: String
}

struct Location {
    let id = ID<Self>()
    let coordinates: (Double, Double)
}

func handle(locations: [Location]) {
    let me = Person(name: "Omer")
    let filtered = locations.filter({ $0.id == me.id })
}
```

# Main vs Global vs Operation Queue
Main UI güncellemesi için. Global daha çok hesaplama vs.
Main senkron çalışır. Global asenkron

Eş zamanlı olarak, birbirinden bağımsız olarak çalışma

