//
//  ContentView.swift
//  Google Translate
//
//  Created by Abdulloh on 10/05/23.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var showTraslation = false
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Text("Russian")
                        .frame(width: (getSize().width-30)/2)
                    
                    Image(systemName: "arrow.left.arrow.right")
                        .frame(width: 25)
                        .foregroundColor(.black.opacity(0.5))
                        .offset(y: 2)
                    
                    Text("English")
                        .frame(width: (getSize().width-30)/2)
                }
                .frame(height: 50)
                .foregroundColor(.blue)
                
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)
                
                HStack(alignment: .top) {
                    TextField("Enter Text", text: $text, axis: .vertical)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                showTraslation = true
                            }
                        }
                        .frame(height: 100, alignment: .top)
                        .padding(.leading)
                        .focused($showKeyboard)
                    
                    Button(
                        action: {
                            text = ""
                            showKeyboard = false
                            withAnimation(.easeInOut(duration: 0.1)) {
                                showTraslation = false
                            }
                        },
                        label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    )
                }
                .padding(.top)
                
                if showTraslation {
                    Divider()
                        .frame(height: 1)
                        .overlay(.gray)
                    
                    HStack() {
                        ScrollView(.vertical, showsIndicators: true) {
                            HStack {
                                Text(text)
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                    .padding(.top, -10)
                                Spacer()
                            }
                        }
                        .frame(height: 100)
                        .padding(.top)
                        
                        Button(
                            action: {
                                if !text.isEmpty {
                                    showKeyboard = false
                                }
                            },
                            label: {
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.headline)
                                    .foregroundColor(text.isEmpty ? .blue.opacity(0.5) : .blue)
                                    .padding(.trailing)
                            }
                        )
                    }
                }
                
                Color.gray
                    .opacity(0.4)
                    .edgesIgnoringSafeArea(.bottom)
            }
            .background(Color.white)
            
            GeometryReader { reader in
                Color.blue
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
        .frame(width: getSize().width)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func getSize() -> CGSize {
    return UIScreen.main.bounds.size
}
