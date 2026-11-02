//
//  HobbyModel.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import Foundation

struct HobbyModel : Identifiable {
    let id : Int
    let hobbyName : String
    let hobbyImage : String
    var isFavorite : Bool = false
}

