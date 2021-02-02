//
//  NetworkManager.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func network(url: String,page: Int, with complition: @escaping ([PhotoModel]) -> Void) {
        var url = url
        url += "&page=\(page)"
    
        guard let urlRequest = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let photoData = try jsonDecoder.decode([PhotoModel].self, from: data)
                DispatchQueue.main.async {
                    complition(photoData)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
