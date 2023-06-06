//
//  ContentView.swift
//  AccessibilityTest
//
//  Created by James Bailey on 25/04/2023.
//
import SwiftUI
import AVFoundation
import Intents

struct ContentView: View {
    @State private var timer: Timer? = nil
    @State private var text = "Enter text below and phone will say it"
    @State var name = ""
    @ObservedObject var emojis = emoji()
    @State private var showingSettingsView = false
    @State private var isLandscape = UIDevice.current.orientation.isLandscape

    let columns = [
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200)),
        GridItem(.adaptive(minimum: 200))
    ]
    
    // Declare the synthesizer as a property of the view
    var synthesizer = AVSpeechSynthesizer()
    

    var body: some View {
        VStack {
            HStack{
                Spacer()

                Button(action: {}) {
                    Text("Hold for 5 seconds")
                }
                .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                    if pressing {
                        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                            self.showingSettingsView = true
                        }
                    } else {
                        self.timer?.invalidate()
                        self.timer = nil
                    }
                }, perform: {})
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView(emojis: self.emojis)
                }

            }
            
            let columns = Array(repeating: GridItem(.flexible()), count: isLandscape ? 4 : 3)
            
            LazyVGrid(columns: columns) {
                ForEach(0..<12) { option in
                    Button(action: {
                        speakEmoji(emojiSelection: emojis.options[option])
                    }) {
                        Text(emojis.emojiList[option]).font(.system(size: 180))
                        
                    }
                }
            }
        }.onAppear {
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                isLandscape = UIDevice.current.orientation.isLandscape
            }
        }
    }
    
    func speakText() {
        // Create an utterance with the text to speak
        let utterance = AVSpeechUtterance(string: name)
        // Use the synthesizer to speak the utterance
        synthesizer.speak(utterance)
    }
    
    func speakEmoji(emojiSelection: String) {
        // Create an utterance with the text to speak
        let utterance = AVSpeechUtterance(string: emojiSelection)
        // Use the synthesizer to speak the utterance
        synthesizer.speak(utterance)
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(emoji())
    }
}
