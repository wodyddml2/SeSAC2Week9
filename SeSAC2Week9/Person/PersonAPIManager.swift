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
        
//        URLSession.request(endpoint: component.url!) { sucess, error in
//
//        }
    }
}
