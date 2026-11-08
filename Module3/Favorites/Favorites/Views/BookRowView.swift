//
//  BookRowView.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/7/26.
//

import SwiftUI

struct BookRowView: View {

    let book: BookModel
    @EnvironmentObject private var favorites: FavoritesViewModel

    // Gives each book its own cover color, picked by id so it never changes.
    private var coverColor: Color {
        let palette: [Color] = [.indigo, .teal, .orange, .pink, .blue, .green, .purple, .brown]
        return palette[book.id % palette.count]
    }

    var body: some View {
        HStack(spacing: 12) {
            // Small "book cover" tile, playing the same role as the hobby emoji
            RoundedRectangle(cornerRadius: 4)
                .fill(coverColor.gradient)
                .frame(width: 40, height: 56)
                .overlay(
                    Image(systemName: "book.closed.fill")
                        .foregroundStyle(.white.opacity(0.9))
                )
                .shadow(radius: 1, y: 1)

            VStack(alignment: .leading, spacing: 2) {
                Text(book.bookTitle)
                    .font(.headline)
                    .lineLimit(2)
                Text(book.bookAuthor)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(action: {
                favorites.toggleFavoriteBook(book: book)
            }) {
                Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(book.isFavorite ? .red : .gray)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    BookRowView(book: BookModel(id: 1, bookTitle: "The Hobbit", bookAuthor: "J.R.R. Tolkien"))
        .environmentObject(FavoritesViewModel())
        .padding()
}
