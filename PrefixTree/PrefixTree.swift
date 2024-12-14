class Word {
    let english: String
    let transcr: String
    let russian: String
    
    init(english: String, transcr: String, russian: String) {
        self.english = english
        self.transcr = transcr
        self.russian = russian
    }
    
    init(line: String) {
        let parts = line.split(separator: "\t")
        english = String(parts[0])
        transcr = String(parts[1])
        russian = String(parts[2])
    }
}

class Node {
    private let size: Int = 26
    private var next: [Node?] = Array(repeating: nil, count: 26)
    var value: Word?
    var isEnd: Bool { value != nil }
    
    init(value: Word? = nil) {
        self.value = value
    }
    
    func next(char: Character) -> Node {
        let index = char.index
        if next[index] == nil {
            next[index] = Node()
        }
        return next[index]!
    }
    
    func get(char: Character) -> Node? {
        let index = char.index
        return next[index]
    }
}

extension Character {
    /// Вычисляет индекс символа в диапазоне [0, 25].
    var index: Int {
        guard let asciiValue = self.asciiValue, asciiValue >= 97, asciiValue <= 122 else {
            fatalError("Character \(self) is out of bounds for lowercase Latin letters")
        }
        return Int(asciiValue - Character("a").asciiValue!)
    }
}

final class PrefixTree {
    private var root: Node
    
    init() {
        self.root = Node()
    }
    
    func put(key: String, word: Word) {
        var node = root
        for char in key {
            node = node.next(char: char)
        }
        node.value = word
    }
    
    func get(key: String) -> Word? {
        var node = root
        for char in key {
            guard let next = node.get(char: char) else {
                return nil
            }
            node = next
        }
        return node.value
    }
}
