//
//  BookModel.swift
//  Favorites
//
//  Created by Jonathon Andrews on 11/1/26.
//

import Foundation

struct BookModel : Identifiable {
    let id : Int
    let bookName : String
    let bookAuthor : String
    var isFavorite : Bool = false
}
