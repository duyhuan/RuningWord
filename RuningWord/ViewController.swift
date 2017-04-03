//
//  ViewController.swift
//  RuningWord
//
//  Created by huan huan on 3/28/17.
//  Copyright © 2017 huan huan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    
    var tagNumber:Int = 100
    var arrView: [UIView] = [UIView]()
    var ta = 0
    var numberOfTag = 0
    var pop = 500
    
    var numberOfChar = 0
    var timer = Timer()
    var letter = Letter()
    var checkPress: Bool = true
    
    var textColor: UIColor = UIColor.blue
    
    var arr: [[[Int]]] = [[[Int]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arr = [letter.arrA, letter.arrB, letter.arrC, letter.arrD, letter.arrE, letter.arrF, letter.arrG, letter.arrH, letter.arrI, letter.arrJ, letter.arrK, letter.arrL, letter.arrM, letter.arrN, letter.arrO, letter.arrP, letter.arrQ, letter.arrR, letter.arrS, letter.arrT, letter.arrU, letter.arrV, letter.arrW, letter.arrX, letter.arrY, letter.arrZ, letter.arr0, letter.arr1, letter.arr2, letter.arr3, letter.arr4, letter.arr5, letter.arr6, letter.arr7, letter.arr8, letter.arr9, letter.arrSpace]
        
        
        for indexRow in 0..<7 {
            for indexCol in 0..<24 {
                let myView = UIView()
                myView.frame.size = CGSize(width: 20.0, height: 20.0)
                myView.tag = tagNumber
                myView.layer.borderColor = UIColor.white.cgColor
                arrView.append(myView)
                view.addSubview(myView)
                myView.center = CGPoint(x: (view.bounds.width - (myView.bounds.width*23))/2 + CGFloat(indexCol) * myView.bounds.width, y: 150.0 + CGFloat(indexRow)*myView.bounds.height)
                tagNumber += 1
            }
            tagNumber += 10 + pop
            
        }
        
        
        for view in arrView {
            numberOfTag = view.tag
        }
        
        ta = numberOfTag
        
    }
    
    @IBAction func handleButtonColor(_ sender: UIButton) {
        textColor = sender.backgroundColor!
    }
    
    
    @IBAction func handleTextField(_ sender: UITextField) {
        numberOfChar = (myTextField.text?.characters.count)!
    }
    
    @IBAction func handleButton(_ sender: UIButton) {
        
        numberOfChar = (myTextField.text?.characters.count)!
        
        if checkPress {
            if myTextField.text != "" {
                checkPress = false
                sender.setTitle("Stop", for: UIControlState.normal)
                timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(run), userInfo: nil, repeats: true)
            }
        } else {
            checkPress = true
            sender.setTitle("Run", for: UIControlState.normal)
            timer.invalidate()
        }
        
    }
    
    func mediate(count: Int, indexI: Int, indexJ: Int, arrMed: [[Int]]) {
        if let viewH = view.viewWithTag(self.tagNumber + 6*count) {
            if arrMed[indexI][indexJ] == 1 {
                viewH.backgroundColor = textColor
            }
        }
    }
    
    func run() {
        
        tagNumber = ta
        
        for view in self.arrView {
            view.backgroundColor = UIColor.white
        }
        
        let s = myTextField.text!
        let s1 = s.uppercased()
        var arrCharacter: [Character] = [Character]()
        for i in 0..<s1.characters.count {
            let index = s1.index(s1.startIndex, offsetBy: i)
            arrCharacter.append(s1[index])
        }
        
        var count = -1
        
        for i in (0..<7).reversed() {
            for j in (0..<5).reversed() {
                
                count = 0
                
                for x in 0..<arrCharacter.count {
                    view.backgroundColor = UIColor.white
                    count += 1
                    for y in 0..<letter.arrAllLetter.count {
                        if letter.arrAllLetter[y] == arrCharacter[x] {
                            mediate(count: count, indexI: i, indexJ: j, arrMed: arr[y])
                        }
                    }
                }
                
                self.tagNumber -= 1
            }
            self.tagNumber = self.tagNumber - 24 - self.pop - 5
        }
        
        
        self.ta -= 1
        
        if self.ta == self.numberOfTag - 24 - 7 - 6*(self.numberOfChar - 1) {
            self.ta = self.numberOfTag
        }
        
    }
    
}
