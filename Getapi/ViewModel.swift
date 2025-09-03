//
//  ViewModel.swift
//  Getapi
//
//  Created by Ricky Vishwas on 31/08/25.
//
import Foundation
import SwiftUI


struct Datalist: Hashable, Codable {
    var name: String
    var image: String
}


class ViewModel: ObservableObject {
    @Published var apidata: [Datalist] = []
    
    func getData() {
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters") else { return }
        
    
    
    let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
        guard let data = data, error == nil else { return }
        
        
        
        // Convert to JSON
        do {
            let datalist = try JSONDecoder().decode([Datalist].self, from: data)
            DispatchQueue.main.async {
                self?.apidata = datalist
            }
        } catch {
            print(error)
        }
    }
        task.resume()
    }
}
