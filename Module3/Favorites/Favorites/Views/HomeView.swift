//
//  Home.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import SwiftUI

enum ContentCategory : String, CaseIterable {
    case cities = "Cities"
    case hobbies = "Hobbies"
    case books = "Books"
    
}

struct HomeView: View {
    @State private var selectedCategory : ContentCategory = .cities
    @State private var searchText : String = ""
    @EnvironmentObject private var favorites : FavoritesViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                Picker("Categories", selection : $selectedCategory) {
                    ForEach(ContentCategory.allCases, id: \.self) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                selectedContentView()
            }
            
            .navigationTitle("Browse")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search \(selectedCategory.rawValue)")
        }
    }
    
    @ViewBuilder
    private func selectedContentView () -> some View {
        switch selectedCategory {
        case .cities:
            CitiesView(searchText: $searchText)
        case .hobbies:
            HobbiesView(searchText: $searchText)
        case .books:
            BooksView(searchText: $searchText)
        }
    }
    
    }


#Preview {
    HomeView()
        .environmentObject(FavoritesViewModel())
}
