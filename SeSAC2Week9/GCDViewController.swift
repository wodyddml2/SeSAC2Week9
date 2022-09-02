//
//  GCDViewController.swift
//  SeSAC2Week9
//
//  Created by J on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!

    @IBOutlet weak var imageFirst: UIImageView!
    @IBOutlet weak var imageSecond: UIImageView!
    @IBOutlet weak var imageThird: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func serialSync(_ sender: UIButton) {
        print("START")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
//        DispatchQueue.main.sync { // 데드락 발생
//            for i in 101...200 {
//                print(i, terminator: " ")
//            }
//        }
        
        print("END")
    }
    
    @IBAction func serialAsync(_ sender: UIButton) { // 보통 UI적인 요소에서 사용
        print("START")
        
//        DispatchQueue.main.async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        for i in 1...100 {
            DispatchQueue.main.async { // queue로 task를 보내고 다음 작업
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
       
        
        print("END")
    }
    
    @IBAction func globalSync(_ sender: UIButton) {
        print("START")
        
        DispatchQueue.global().sync { // 쓸 일 없음 어차피 순서대로 sync로 가기에 메인으로 보내서 처리하기에 사용 필요 없음
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("END")
    }
    
    @IBAction func globalAsync(_ sender: UIButton) {
        print("START\(Thread.isMainThread)", terminator: " ")
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
            
        }
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END \(Thread.isMainThread)")
    }
    @IBAction func qos(_ sender: UIButton) {
        // 무슨 작업을 하는지 명시적으로 나타내고 싶을 때
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        
        customQueue.async {
            print("START")
        }
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async { // 우선순위 마지막
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            DispatchQueue.global(qos: .userInteractive).async { // 우선순위 처음
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .utility).async { // 중간쯤
                print(i, terminator: " ")
            }
        }
    }
    // tmdb에서 네트워크 통신하면서 작업의 순서가 보장이 되지 않고 끝나는 시점을 몰라서 코드를 순서대로 길게 나열한 적이 있는데
    // 그것을 효율적으로 바꾸기 위해 그룹화해준다.
    // 여러 API를 하나의 뷰에 뿌려줄때 써볼 수도 있음
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        // 그룹의 신호를 준다.
        group.notify(queue: .main) {
            print("END")
        }
        
    }
    @IBAction func dispatchGroupNASA(_ sender: UIButton) {
//        request(url: url1) { image in // 순서대로 진행이되어 시간이 좀 지연된다.
//            print("1")
//            self.request(url: self.url2) { image in
//                print("2")
//                self.request(url: self.url3) { image in
//                    print("3")
//                }
//            }
//        }
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url1) { image in
                print("1")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url2) { image in
                print("2")
            }
        }
        DispatchQueue.global().async(group: group) {
            self.request(url: self.url3) { image in
                print("3")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
        }
        
        
    }
    
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
            // 임의로 비동기 코드로 처리되어있음
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completionHandler(UIImage(systemName: "star"))
                    return
                }

                let image = UIImage(data: data)
                completionHandler(image)
                                      
            }.resume()
        }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()
        var imageList: [UIImage] = []
        
        // 비동기 코드로 처리되는 코드를 그룹으로 묶어 처리하기 위한 코드
        group.enter() // RC + 1
        self.request(url: self.url1) { image in
//            DispatchQueue.main.sync {
//                self.imageFirst.image = image
//            }
            imageList.append(image!)
            group.leave() // RC - 1
        }
        
        group.enter()
        self.request(url: self.url2) { image in
//            DispatchQueue.main.sync {
//                self.imageSecond.image = image
//            }
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        self.request(url: self.url3) { image in
//            DispatchQueue.main.sync { // 이렇게 하면 먼저 나오는 순대로 이미지가 로드
//                self.imageThird.image = image
//            }
            imageList.append(image!)
            group.leave()
        }
        
        
        group.notify(queue: .main) { // 한 번에 이미지 로드
            self.imageFirst.image = imageList[0]
            self.imageSecond.image = imageList[1]
            self.imageThird.image = imageList[2]
            print("끝")
        }
        
    }
    
    @IBAction func raceCondition(_ sender: Any) {
        
        let group = DispatchGroup()
        
        var nickname = "SeSAC"
        // 비동기이기에 같은 변수로 공유 자원을 쓴다면 문제가 생길 수 있음 race condition
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "JJ"
            print("first: \(nickname)")
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "Joker"
            print("second: \(nickname)")
        }
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "BB"
            print("third: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
    
}
