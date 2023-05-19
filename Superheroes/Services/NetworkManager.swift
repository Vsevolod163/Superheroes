//
//  NetworkManager.swift
//  Superheroes
//
//  Created by Vsevolod Lashin on 19.05.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct NetworkManager {
    static var networkManager = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: URL, completion: @escaping(Result<[Superhero], NetworkError>) -> Void) {
        guard let url = URL(string: "https://cdn.rawgit.com/akabab/superhero-api/0.2.0/api/all.json") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let superheroes = try jsonDecoder.decode([Superhero].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(superheroes))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
