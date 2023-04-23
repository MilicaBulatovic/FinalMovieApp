//
//  SearchBarView.swift
//  FinalAsigmentMovieApp
//
//  Created by obuke on 09/04/2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @State var searchText: String = ""
    @State var isFocused: Bool = false
    @State var isToggleOn = false
    // @State var rotationAngle = Angle(degrees: 100)
    
    var body: some View {
        
        
        HStack {
            TextField("Search", text: $searchText)
                .frame(height: 30)
                .padding(.horizontal, 10)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(80)
                .overlay(
                    HStack {
                        
                        Image(systemName: "magnifyingglass")
                            
                            .rotationEffect(Angle(degrees: 100))
                            .foregroundColor(Color(.systemGray))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                        
                        
                        if self.isFocused {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                    .cornerRadius(80)
                    .padding(.horizontal, 0.0)
                )
                .onTapGesture {
                    self.isFocused = true
                }
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            if isFocused {
                Button(action: {
                    
                    self.isFocused = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
            
        }
        
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
            .preferredColorScheme(.dark)
    }
}
