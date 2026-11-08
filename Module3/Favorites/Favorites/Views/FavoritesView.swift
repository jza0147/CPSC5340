//
//  FavoritesView.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject private var favorites: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Group {
                if favorites.hasFavorites {
                    ScrollView {
                        VStack(spacing: 28) {

                            if !favorites.favoriteCities.isEmpty {
                                FavoritesSection(title: "Cities",
                                                 systemImage: "building.2.fill",
                                                 tint: .blue,
                                                 count: favorites.favoriteCities.count) {
                                    VStack(spacing: 12) {
                                        ForEach(favorites.favoriteCities) { city in
                                            CityCardView(city: city)
                                        }
                                    }
                                }
                            }

                            if !favorites.favoriteHobbies.isEmpty {
                                FavoritesSection(title: "Hobbies",
                                                 systemImage: "paintpalette.fill",
                                                 tint: .orange,
                                                 count: favorites.favoriteHobbies.count) {
                                    RowGroup(items: favorites.favoriteHobbies) { hobby in
                                        HobbyRowView(hobby: hobby)
                                    }
                                }
                            }

                            if !favorites.favoriteBooks.isEmpty {
                                FavoritesSection(title: "Books",
                                                 systemImage: "books.vertical.fill",
                                                 tint: .purple,
                                                 count: favorites.favoriteBooks.count) {
                                    RowGroup(items: favorites.favoriteBooks) { book in
                                        BookRowView(book: book)
                                    }
                                }
                            }
                        }
                        .padding()
                        .animation(.easeInOut(duration: 0.25), value: favoriteKeys)
                    }
                    .background(Color(.systemGroupedBackground))
                } else {
                    ContentUnavailableView(
                        "No Favorites Yet",
                        systemImage: "heart",
                        description: Text("Tap the heart on any city, hobby, or book to save it here.")
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }

    
    private var favoriteKeys: [String] {
        favorites.favoriteCities.map { "c\($0.id)" }
        + favorites.favoriteHobbies.map { "h\($0.id)" }
        + favorites.favoriteBooks.map { "b\($0.id)" }
    }
}



private struct FavoritesSection<Content: View>: View {
    let title: String
    let systemImage: String
    let tint: Color
    let count: Int
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 10) {
                Image(systemName: systemImage)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)
                    .frame(width: 30, height: 30)
                    .background(tint.gradient, in: RoundedRectangle(cornerRadius: 8, style: .continuous))

                Text(title)
                    .font(.title3.bold())

                Spacer()

                Text("\(count)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(tint)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(tint.opacity(0.15), in: Capsule())
            }

            content()
        }
    }
}



private struct RowGroup<Item: Identifiable, Row: View>: View {
    let items: [Item]
    @ViewBuilder let row: (Item) -> Row

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                row(item)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)

                if index < items.count - 1 {
                    Divider()
                        .padding(.leading, 16)
                }
            }
        }
        .background(Color(.secondarySystemGroupedBackground),
                    in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
