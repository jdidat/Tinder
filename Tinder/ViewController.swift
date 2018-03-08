//
//  ViewController.swift
//  Tinder
//
//  Created by Jackson Didat on 3/4/18.
//  Copyright © 2018 jdidat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cardInitialCenter: CGPoint!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func dragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        if sender.state == .began {
            cardInitialCenter = location
        }
        else if sender.state == .changed {
            if cardInitialCenter.y <= imageLabel.frame.height/2 {
                imageLabel.transform = CGAffineTransform(translationX: translation.x, y: 0)
                imageLabel.transform = imageLabel.transform.rotated(by: CGFloat(Double(translation.x)/10 * Double.pi / 180))
            }
            else {
                imageLabel.transform = CGAffineTransform(translationX: translation.x, y: 0)
                imageLabel.transform = imageLabel.transform.rotated(by: CGFloat(-Double(translation.x)/10 * Double.pi / 180))
            }
        }
        else if sender.state == .ended {
            if translation.x > 50 {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.imageLabel.transform = CGAffineTransform(translationX: velocity.x * 100, y: 0)
                }, completion: nil)
            }
            else{
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.imageLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    }
    
    
    @IBAction func onImageTap(_ sender: UITapGestureRecognizer) {
        print("hi")
        performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "profileSegue"){
            let profileDetails = segue.destination as! ProfileViewController
            profileDetails.image = self.imageLabel.image
        }
    }
    
}

