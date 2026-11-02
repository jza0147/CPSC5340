//
//  CityCardView.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import SwiftUI

struct CityCardView: View {
    
    let city : CityModel
    @EnvironmentObject private var favorites: FavoritesViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(city.cityImage)
                .resizable()
                .scaledToFill()
                .frame(height: 140)
                .clipped()

            HStack {
                Text(city.cityName)
                    .font(.system(size: 18, weight: .bold)) // keep your existing weight
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.black.opacity(0.35))

                Spacer()
                Button(action: {
                    print("Tapped for \(city.cityName)")
                    
                }) {
                    Image(systemName: city.isFavorite ? "heart.fill" : "heart")
                        .padding(6)
                        .foregroundStyle(city.isFavorite ? .red : .white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CityCardView(city: CityModel(id: 1, cityName: "Amsterdam", cityImage: "amsterdam", isFavorite: false))
}
