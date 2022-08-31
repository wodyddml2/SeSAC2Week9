import Foundation

class PersonAPIManager {
    static func requestPerson(query: String, completionHandler: @escaping (Person?, APIError?) -> Void) {
        
        //
        //        let url = URL(string: "https://api.themoviedb.org/3/search/person?api_key=6524d71f25d128df02ba5cdc8d700c84&language=en-US&query=\(query)&page=1&include_adult=false&region=ko-KR")!
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        
        let language = "ko-KR"
        let key = "6524d71f25d128df02ba5cdc8d700c84"
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "region", value: language)
        ]
        
        //        let a = URLRequest(url: url).setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        URLSession.shared.dataTask(with: component.url!) { data, response, error in //실질적으론 error -> response -> data 순
            
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Failed Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }
                do {
                    
                    let result = try JSONDecoder().decode(Person.self, from: data)
                    print(result)
                    completionHandler(result, nil)
                    
                } catch {
                    
                    print(error)
                    completionHandler(nil, .invalidData)
                    
                }
            }
            
        }.resume()
        
    }
}
