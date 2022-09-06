//
//  LocalizationViewController.swift
//  SeSAC2Week9
//
//  Created by J on 2022/09/06.
//

import UIKit
import MessageUI // 메일로 문의 보내기, 디바이스 테스트, 아이폰 메일 계정을 등록해야 가능.
import CoreLocation

class LocalizationViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "navigation_title".localized
        
        // 나는 0살입니다.
        // I am 0 years old.
        myLabel.text = "introduce".localized(with: "고래밥")
        inputTextField.text = "number_test".localized(with: 26)
        
        searchBar.placeholder = "search_placeholder".localized
        
        inputTextField.placeholder = "main_age_placeholder".localized
        
        let buttonTitle = "common_cancel".localized
        sampleButton.setTitle(buttonTitle, for: .normal)
        
        CLLocationManager().requestWhenInUseAuthorization()
    }
    
    func sendMail() {
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.setToRecipients(["wodyddml2@gmail.com"])
            mail.setSubject("다이어리 문의사항 -")
            // option사항
            mail.mailComposeDelegate = self
            
            self.present(mail, animated: true)
            
            
        } else {
            print("메일 등록을 해주세요, ..@naver.com으로 문의 주세요 등의 얼럿")
        }
    }
    
    // option 명확하게 취소나 성공을 사용자에게 알려주고 싶을때
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            <#code#>
        case .saved:
            <#code#>
        case .sent:
            <#code#>
        case .failed:
            <#code#>
        }
        controller.dismiss(animated: true)
    }

}

// 별도 파일로 빼기
extension String {
    // comment는 협업 시 커뮤니케이션을 위함
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized<T>(with: T) -> String {
        return String(format: self.localized, with as! CVarArg)
    }
   
}
