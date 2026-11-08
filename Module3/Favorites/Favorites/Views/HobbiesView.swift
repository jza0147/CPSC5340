//
//  HobbiesView.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/6/26.
//

import SwiftUI

struct HobbiesView: View {
    @EnvironmentObject var favorites: FavoritesViewModel
    @Binding var searchText: String
    
    
    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEach(favorites.filteredHobbies(searchText: searchText)) { hobby in
                    HobbyRowView(hobby: hobby)
                    
                }
            }
            .padding()
        }
    }
}


