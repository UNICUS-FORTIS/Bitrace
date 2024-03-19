//
//  ContentView.swift
//  Bitrace
//
//  Created by LOUIE MAC on 3/16/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
            VStack {
                
                HStack {
                    Text("Bitrace")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Image(.searchIcon)
                            .resizable()
                            .foregroundStyle(.main)
                            .frame(maxWidth: 25, maxHeight: 25)
                            .padding(.trailing)
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: 30)
                .padding(.top, 36)
                
                bannerView()
                    .frame(height: 200)
                    .padding(.vertical)
                
                Text("Market")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity,
                           maxHeight: 20,
                           alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 12)

                ScrollView {
                    coinListView()
                }
                
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Bitrace")
            .navigationBarTitleTextColor(.main)
        }
}

#Preview {
    MainView()
}