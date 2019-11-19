//
//  ViewController.swift
//  Demo3
//
//  Created by SHIH-YING PAN on 2019/11/19.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import UIKit
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func fetchImage(url: URL?, completionHandler: @escaping (UIImage?) -> ()) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    completionHandler(image)
                } else {
                    completionHandler(nil)
                }
            }
            task.resume()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let _ = AccessToken.current {
            Profile.loadCurrentProfile { (profile, error) in
                if let profile = profile {
                    self.label.text = profile.name
                    let url = profile.imageURL(forMode: .square, size: CGSize(width: 300, height: 300))
                    
                    self.fetchImage(url: url) { (image) in
                        DispatchQueue.main.async {
                            self.imageView.image = image

                        }
                    }
                }
            }
        }
    }


}

