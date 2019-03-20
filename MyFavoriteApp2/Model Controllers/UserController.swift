//
//  UserController.swift
//  MyFavoriteApp2
//
//  Created by Cody on 3/20/19.
//  Copyright © 2019 Cody Adcock. All rights reserved.
//

import Foundation

class UserController{
    
    // Shared Instance
    static let shared = UserController()
    private init (){}
    
    // Source of Truth
    var users: [User] = []
    
    // Base URL
    let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    // MARK: - CRUD Functions
    
    // GET Request (READ)
    func getUsers(completion: @escaping (Bool) -> Void){
        //URL
        guard var url = baseURL else {completion(false); return}
        url.appendPathComponent("users")
        //https://favoriteapp-375c6.firebaseio.com/users
        url.appendPathExtension("json")
        //https://favoriteapp-375c6.firebaseio.com/users.json
        print(url)
        
        //URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //Data Task + RESUME
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                print("There was an error retrieving the data: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
            if let response = response{
                print(response)
            }
            guard let data = data else {completion(false) ; return}
            let decoder = JSONDecoder()
            
            do{
                let dictionaryOfUsers = try decoder.decode([String : User].self, from: data)
                var tempUsers: [User] = []
                for(_,value) in dictionaryOfUsers {
                   tempUsers.append(value)
                }
                self.users = tempUsers
                completion(true)
                
            }catch{
                print("There was an error decoding the data: \(error) \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    
    // POST Request (UPDATE)
    
}
