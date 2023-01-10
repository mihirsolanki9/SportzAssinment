//
//  DetailsNewsVC.swift
//  VIPER DEMO
//
//  Created by Mihir Solanki on 28/08/22.
//

import UIKit
import WebKit

protocol DetailsNewsViewProtocol: AnyObject{
}

class DetailsVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var presenter: DetailsNewsPresenter?
    var newsUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: newsUrl) else {return}
        webView.load(URLRequest(url: url))

    }
    @IBAction func bacBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension DetailsVC: DetailsNewsViewProtocol{
    
}
