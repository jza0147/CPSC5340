//
//  CityModel.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import Foundation

struct CityModel : Identifiable {
    let id : Int
    let cityName : String
    let cityImage : String
    var isFavorite : Bool = false
}
