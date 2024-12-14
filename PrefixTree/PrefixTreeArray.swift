class KeyNode<Value> {
    private let size: Int = 26
    private var next: [KeyNode?] = Array(repeating: nil, count: 26)
    var value: Value?
    var isEnd: Bool { value != nil }
    
    init(value: Value? = nil) {
        self.value = value
    }
    
    func next(char: Character) -> KeyNode {
        let index = char.index
        if next[index] == nil {
            next[index] = KeyNode()
        }
        return next[index]!
    }
    
    func get(char: Character) -> KeyNode? {
        let index = char.index
        return next[index]
    }
    
    func remove(char: Character) {
        let index = char.index
        next[index] = nil
    }
}

extension KeyNode {
    /// Проверяет, является ли узел листом.
    var isLeaf: Bool {
        return next.allSatisfy { $0 == nil }
    }
}



final class PrefixTreeArray<Value> {
    private var root: KeyNode<Value>
    
    init() {
        self.root = KeyNode()
    }
    
    /// Добавляет значение в ассоциативный массив.
    func put(key: String, value: Value) {
        var node = root
        for char in key {
            node = node.next(char: char)
        }
        node.value = value
    }
    
    /// Возвращает значение по ключу.
    func get(key: String) -> Value? {
        var node = root
        for char in key {
            guard let next = node.get(char: char) else {
                return nil
            }
            node = next
        }
        return node.value
    }
    
    /// Удаляет значение по ключу.
    func remove(key: String) {
        func removeHelper(node: KeyNode<Value>?, key: String, depth: Int) -> Bool {
            guard let node = node else { return false }
            
            // Если достигли конца ключа
            if depth == key.count {
                node.value = nil
                return node.isLeaf
            }
            
            // Рекурсивно удаляем
            let char = key[key.index(key.startIndex, offsetBy: depth)]
            if removeHelper(node: node.get(char: char), key: key, depth: depth + 1) {
                node.remove(char: char)
                return node.isLeaf && node.value == nil
            }
            
            return false
        }
        
        _ = removeHelper(node: root, key: key, depth: 0)
    }
}


