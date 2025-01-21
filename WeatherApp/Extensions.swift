//
//  Extensions.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import Foundation
import SwiftUI

extension Image {
    func data(url:URL) -> Self {
        if let data = try? Data(contentsOf: url) {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

extension String {
    func load() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data : Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        }
        catch {
            
        }
        return UIImage()
    }
}
