//
//  NetworkManager.swift
//  urlReques test another method
//https://randomuser.me/api/?gender=male
//  Created by Иван Галиченко on 03.09.2024.
//

import Foundation

class NetworkManager {
    
    func getNews(count: String,completion: @escaping ([whatContainsResponce])->()) {
        // 1 нужна сама айпишка
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "randomuser.me"
        urlComponent.path = "/api/?gender=male&results=3"
        
        // тут я пишу все параметры для запроса вроде пола результатов и тд, какие ключевые слова есть для запроса просто посмотри в самом сайте откуда делаешть запросб сейчас это https://randomuser.me
        urlComponent.queryItems = [
            URLQueryItem(name: "gender", value:  "male"),
            URLQueryItem(name: "results", value:  count)
        ]
        //2 запрос на нее
        if let url = urlComponent.url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            //3 получить и преобразовать данные
            URLSession.shared.dataTask(with: request) { data, responce, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                
                if let responceData = data {
                    
                    do {
                     let responceFromMyKeywords = try JSONDecoder().decode(ResponceFromApi.self, from: responceData)
                        //responceFromMyKeywords это еще не ответ и чтобы он появился не забудь дописать это
                        completion(responceFromMyKeywords.results)
                        
                    } catch let error {
                        print(error.localizedDescription)
                        return
                        
                    }
                }
                
            }.resume()
            
        }
        
        
        
   
    }
}

// вот тут при создании надо смотреть на скобки на сайте https://web.postman.co/workspace/My-Workspace~c80a066f-bfc0-48c0-8522-8abfd4ae7252/request/create?requestId=613feba5-7fd0-451d-b082-c2f51a4337d0 чтобы понять массив это структура или что-то еще ,один из видосиков говорит что тут больше всего ошибаются

struct ResponceFromApi: Decodable {
    var results: [whatContainsResponce]
}
// делай опциональными а то вдруг не придет что-то и гг и еще first и country это ключевые слова которые есть в ответе от https://randomuser.me там имя пол и тд и это есть тоже так вот эти ключевые слова должны быть ТАКИМИ ЖЕ как в ответе иначе ошибка а вот само название структуры все неважно какое 
struct whatContainsResponce: Decodable {
    var first: String?
    var country:String?
}
