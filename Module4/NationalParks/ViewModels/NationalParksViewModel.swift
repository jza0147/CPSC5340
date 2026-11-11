//
//  NationalParksViewModel.swift
//  NationalParks
//
//  Created by Jonathon Andrews on 11/10/26.
//

import Foundation

class NationalParksViewModel : ObservableObject {
    @Published var introPages : [IntroPage] = []
    
    
    func loadIntroPages() {
        guard introPages.isEmpty else { return }
        
        let captions = ["Discover America's wild places",
                        "Plan your perfect park day",
                        "Learn about park activites and details",
                        "Start exploring national parks today"]
        
        let randomImages = (1...15)
            .map { String($0) }
            .shuffled()
            .prefix(4)
        
        introPages = zip(randomImages, captions).map {
            IntroPage(imageName: $0, caption: $1)
        }
    }
}
