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
    @State var translate = false
    @FocusState var showKeyboard: Bool
    @ObservedObject var viewModel = ViewModel()
    
    var languages = [
        "ru": "Russian",
        "en": "English"
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Text("\(languages[viewModel.languages[1]]!)")
                        .frame(width: (getSize().width-30)/2)
                    
                    Button(
                        action: {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                viewModel.languages.reverse()
                            }
                        },
                        label: {
                            Image(systemName: "arrow.left.arrow.right")
                                .frame(width: 25)
                                .foregroundColor(.black.opacity(0.5))
                                .offset(y: 2)
                        }
                    )
                    
                    Text("\(languages[viewModel.languages[0]]!)")
                        .frame(width: (getSize().width-30)/2)
                }
                .frame(height: 50)
                .foregroundColor(.blue)
                
                Divider()
                    .frame(height: 1)
                    .overlay(.gray)
                
                HStack(alignment: .top) {
                    TextField("Enter Text", text: $text)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                showTraslation = true
                            }
                        }
                        .submitLabel(.done)
                        .frame(height: 100, alignment: .top)
                        .padding(.leading)
                        .focused($showKeyboard)
                    
                        .onSubmit {
                            translate = true
                            viewModel.postRequest(text: text)
                        }
                    
                    Button(
                        action: {
                            text = ""
                            showKeyboard = false
                            translate = false
                            viewModel.translation.data.translations[0].translatedText = ""
                            
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
                                Text(translate ? viewModel.translation.data.translations[0].translatedText : text)
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
                                    translate = true
                                    viewModel.postRequest(text: text)
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

