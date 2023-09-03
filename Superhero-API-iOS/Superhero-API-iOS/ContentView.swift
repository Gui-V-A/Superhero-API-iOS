//
//  ContentView.swift
//  Superhero-API-iOS
//
//  Created by Guilherme Antonini on 03/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var contentViewModel = ContentViewModel()
    
    private var superHeroID: SuperHeroID = .antMan
    
    var body: some View {
        switch contentViewModel.state {
        case .loaded:
            loadedView
        case .loading:
            loadingView
        case .idle:
            loadingView
        }
    }
}

extension ContentView {
    @ViewBuilder
    var loadingView: some View {
        VStack {
            ProgressView()
                .onAppear {
                    Task {
                        try await contentViewModel.fetch(superHeroID.description)
                    }
                }
        }
    }
    
    @ViewBuilder
    var loadedView: some View {
        VStack(spacing: 20) {
            HStack {
                Text(contentViewModel.superhero.name)
                    .bold()
                    .font(.title)
                Spacer()
            }
            
            Image(uiImage: contentViewModel.uiImage)
                .resizable()
                .clipShape(Circle())
                .frame(width: 200, height: 200)
            
            List {
                Text("Full name: \(contentViewModel.superhero.biography.fullName)")
                Text("Alter egos: \(contentViewModel.superhero.biography.alterEgos)")
                Text("Place of birth: \(contentViewModel.superhero.biography.placeOfBirth)")
                Text("Alignment: \(contentViewModel.superhero.biography.alignment)")
                Text("First apperance: \(contentViewModel.superhero.biography.firstAppearance)")
                Text("Publisher: \(contentViewModel.superhero.biography.publisher)")
            }
            .listStyle(.plain)
            
            HStack {
                Text("💥 \(contentViewModel.superhero.powerstats.power)")
                Spacer()
                Text("⚔️ \(contentViewModel.superhero.powerstats.combat)")
                Spacer()
                Text("🛡️ \(contentViewModel.superhero.powerstats.durability)")
            }
            
            HStack {
                Text("🧠 \(contentViewModel.superhero.powerstats.intelligence)")
                Spacer()
                Text("🏃‍♂️ \(contentViewModel.superhero.powerstats.speed)")
                Spacer()
                Text("💪 \(contentViewModel.superhero.powerstats.strength)")
            }
            
            Spacer()
        }
        .padding(.all, 16)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
