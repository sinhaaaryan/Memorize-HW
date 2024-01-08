//
//  ContentView.swift
//  Memorize
//
//  Created by Aaryan Sinha on 12/3/23.
//

import SwiftUI


// The struct "ContentView" behaves like a View
struct ContentView: View {
    let vehicleEmojis: Array<String> = ["✈️", "🚀", "🚗", "🚘", "🚙", "🛫", "🛬", "🛵", "🚌", "🚐", "🚛", "🚍", "🚜", "🛴", "🚊", "🚲", "🚕", "🚔", "🚚", "🚞", "🚉"]
    
    let emotionEmojis: Array<String> = ["😀", "😊", "😃", "😄", "😆", "🥹", "😅", "🤣", "😍", "🤨", "🧐", "🤓", "😔", "😒", "😖", "😫", "🥺"]
    
    let foodEmojis: Array<String> = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍑", "🥭", "🍍", "🥥", "🥝", "🍆"]
    
    @State var emojis: Array<String> = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍑", "🥭", "🍍", "🥥", "🥝", "🍆"]
    
    
    // Represents color of cards
    // For changing cardColor, need to have it automatically generate
    @State var cardColor: Color = .orange
    
    
    
    

    
    @State var cardCount: Int = 8
    var body: some View {
        VStack {
            ScrollView {
                title
                getCards(by: emojis, c: cardColor)
//                cards
            }

            Spacer()
            themeChooseAdjusters
//            cardCountAdjusters
        }.padding()
    }
    
    
    // Represents the title of the application
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    
    
    
    // Represents a HStack that contains theme choosing buttons
    var themeChooseAdjusters: some View {
        HStack {
            vehicleTheme
            Spacer()
            emotionTheme
            Spacer()
            foodTheme
            
            // Three buttons representing three themes
            // Have to pick out three themes
            
        }
    }
    
    // Represents a view with a button and text for the vehicle theme
    var vehicleTheme : some View {
        VStack {
            themeChooseAdjusterSymbol(by: vehicleEmojis, symbol: "car", cColor: .blue).font(.system(size: 28))
            Text("Vehicle Theme").font(.system(size: 12))
            
        }
    }
    
    var emotionTheme : some View {
        return VStack {
            themeChooseAdjusterSymbol(by: emotionEmojis, symbol: "camera.metering.unknown", cColor: .yellow).font(.system(size: 28))
            Text("Unknown Theme").font(.system(size: 12))
            
        }
    }
    var foodTheme : some View {
        VStack {
            
            themeChooseAdjusterSymbol(by: foodEmojis, symbol: "carrot", cColor: .orange).font(.system(size: 28))
            Text("Food Theme").font(.system(size: 12))
            
        }
    }
    
    
    // Returns a button that changes theme according to given emojis
    // cColor represents card color
    func themeChooseAdjuster(by e: Array<String>, text: String, cColor: Color) -> some View {
        return Button(action: {
            emojis = e
            cardColor = cColor
        }, label: {
            Text(text)
        })
        
    }
    
    func themeChooseAdjusterSymbol(by e: Array<String>, symbol: String, cColor: Color) -> some View {
        Button(action: {
            emojis = e
            cardColor = cColor
        }, label: {
            Image(systemName: symbol)
        })
        
    }
    
    
//    // Represents a button to choose the theme of a button
//    var themeChooseButton: some View {
//        
//    }
    
    
    
    // Takes an array of emojis e and returns a shuffled pairs version of array
    func getEmojiPairsShuffled(by e: Array<String>) -> Array<String> {
        var pairs = e + e
        pairs.shuffle()
        return pairs
    }
    
    // c represents card color
    func getCards(by e: Array<String>, c: Color) -> some View {
        let pairs = getEmojiPairsShuffled(by: e)
//        print(pairs)
        
        return
        // So it is a shuffled version however we are only adding one cardview to each
        // LazyVGrid
        
        
        // Consider the minimum for grid sizing
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<pairs.count, id: \.self) { index in
                
                
                
                CardView(content: pairs[index]).aspectRatio(2/3, contentMode: .fit)
                

            }.foregroundColor(c)
            
        }
    }
    
    var cards: some View {
        // Should display it randomly
        
        
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
                // Second CardView() for putting pair of cards
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
                

            }.foregroundColor(.orange)
            
        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
            
        }.imageScale(.large).font(.largeTitle)
    }
    
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount = cardCount + offset


        }, label: {
            Image(systemName: symbol)
        }).disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
        
    }
    
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder : some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    
    
    // Views are immutable, however if you use @State (which creates a pointer to variable),
    // you can temporarily make it mutable.
    @State var isFaceUp = false
    let content: String
    
    
    
    var body: some View {
        ZStack (alignment: .center)  {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)

        }.onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}


#Preview {
    ContentView()
}
