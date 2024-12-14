//
//  main.swift
//  PrefixTree
//
//  Created by Данил Менделев on 14.12.2024.
//

let lines = [
    "cat\t[c'a't]\tкошка",
    "bat\t[b'a't]\tлетучая мышь",
    "rat\t[r'a't]\tкрыса",
    "can\t[c'a'n]\tмогу",
]


let book = PrefixTree()

lines.forEach { line in
    let word = Word(line: line)
    book.put(key: word.english, word: word)
}

print()


let map = PrefixTreeArray<String>()

// Добавляем ключи
map.put(key: "apple", value: "яблоко")
map.put(key: "ape", value: "обезьяна")
map.put(key: "app", value: "приложение")


if let value = map.get(key: "apple") {
    print("apple: \(value)")
} else {
    print("apple not found")
}

if let value = map.get(key: "app") {
    print("app: \(value)")
} else {
    print("app not found")
}

map.remove(key: "apple")
if let value = map.get(key: "apple") {
    print("apple: \(value)")
} else {
    print("apple not found")
}
