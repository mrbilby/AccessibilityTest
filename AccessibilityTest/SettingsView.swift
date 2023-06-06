//
//  SettingsView.swift
//  AccessibilityTest
//
//  Created by James Bailey on 29/05/2023.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var emojis: emoji

    var body: some View {
        List {
            ForEach(Array(zip(emojis.options.indices, emojis.options)), id: \.0) { index, _ in
                HStack {
                    TextField("Option", text: $emojis.options[index])
                    TextField("Emoji", text: $emojis.emojiList[index])
                }
            }
        }
    }
}


