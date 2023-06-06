//
//  Emojis.swift
//  AccessibilityTest
//
//  Created by James Bailey on 29/05/2023.
//

import Foundation

class emoji: ObservableObject, Codable {
    @Published var options = ["Toilet", "Food", "Car", "Bed", "Walk", "Television", "Story", "Home", "Clothes", "Cold", "Hot", "Sick"] {
        didSet {
            save()
        }
    }
    @Published var emojiList = ["🚽", "🍔", "🚗", "🛌", "🚶‍♀️", "📺","📖", "🏡", "👕", "🥶", "🥵", "🤢"] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    enum CodingKeys: CodingKey {
        case options, emojiList
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        options = try container.decode([String].self, forKey: .options)
        emojiList = try container.decode([String].self, forKey: .emojiList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(options, forKey: .options)
        try container.encode(emojiList, forKey: .emojiList)
    }
    func save() {
        let encoder = JSONEncoder()
        if let encodedOptions = try? encoder.encode(options),
           let encodedEmojiList = try? encoder.encode(emojiList) {
            UserDefaults.standard.set(encodedOptions, forKey: "Options")
            UserDefaults.standard.set(encodedEmojiList, forKey: "EmojiList")
        }
    }

    func load() {
        let decoder = JSONDecoder()
        if let optionsData = UserDefaults.standard.data(forKey: "Options"),
           let emojiListData = UserDefaults.standard.data(forKey: "EmojiList"),
           let decodedOptions = try? decoder.decode([String].self, from: optionsData),
           let decodedEmojiList = try? decoder.decode([String].self, from: emojiListData) {
            options = decodedOptions
            emojiList = decodedEmojiList
        }
    }
    
    

}
