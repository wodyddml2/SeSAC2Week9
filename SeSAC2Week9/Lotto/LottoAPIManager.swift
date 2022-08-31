import Foundation

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidData
}

// shared - 단순한 네트워크 요청일 때 사용 , 응답은 클로저로 전달 받음, 백그라운드 전송 불가
// init(configuration:) - custom 할 때
    // configuration: default - shared와 유사한 구조로 이루어져 있지만 custom(ex. 셀룰러 연결 여부, 타임 아웃 간격) 가능, 응답 클로저 or delegate

class LottoAPIManager {
    
    static func requestLotto(drwNo: Int, completionHandler: @escaping (Lotto?, APIError?) -> Void) {
        
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(drwNo)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Fail Request")
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
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
            
           
            
        }.resume()
    }
    
}
