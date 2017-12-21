//
//  RoutineCollectionViewCell.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 14/12/2017.
//  Copyright © 2017 gyoungeun ola bae. All rights reserved.
//

import UIKit
import RealmSwift
class RoutineCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate  {
    var routineList: Routine!
    let realm = try? Realm()
    @IBOutlet weak var routineName: UILabel!
    @IBOutlet weak var routineButton: UISwitch!
    @IBOutlet weak var routineColor: UIView!
    var pan: UIPanGestureRecognizer!
    var deleteLabel1: UILabel!
    var deleteLabel2: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        self.contentView.backgroundColor = UIColor.gray
        self.backgroundColor = UIColor.black
        
       
        deleteLabel1 = UILabel()
        deleteLabel1.text = "Delete?"
        deleteLabel1.textColor = UIColor.white
        self.insertSubview(deleteLabel1, belowSubview: self.contentView)
        
      
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (pan.state == UIGestureRecognizerState.changed) {
            let p: CGPoint = pan.translation(in: self)
            let width = self.contentView.frame.width
            let height = self.contentView.frame.height
            self.contentView.frame = CGRect(x: 0,y: p.y, width: width, height: height)
            
            self.deleteLabel1.frame = CGRect(x: self.bounds.midX/2+30, y: height/12, width: width, height: height)
            deleteLabel1.font = UIFont(name: "BM DoHyeon OTF", size: 30.0)
        }
        
    }
    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.began {
            
        } else if pan.state == UIGestureRecognizerState.changed {
            self.setNeedsLayout()
        } else {
            if abs(pan.velocity(in: self).y) > 500 {
                let collectionView: UICollectionView = self.superview as! UICollectionView
                let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
                    collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                })
            }
        }
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return abs((pan.velocity(in: pan.view)).y) > abs((pan.velocity(in: pan.view)).x)
    }
}
