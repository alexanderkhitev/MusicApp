//
//  DataManager.swift
//  MusicApp
//
//  Created by Alexsander  on 3/15/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import Sync
import Foundation
import Alamofire
import DATAStack
import UIKit

@objc public protocol DataManagerDelegate {
    optional func dataManagerDidLoad()
}

public class DataManager {
    // MARK: - var and let
    private var dataStack: DATAStack!
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
    private let url = "http://tomcat.kilograpp.com/songs/api/songs"
    public weak var delegate: DataManagerDelegate?
    
    // MARK: - func
    public func download() {
        dataStack = appDelegate.dataStack
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            if response.result.isSuccess {
                if let songArray = response.result.value as? [[String : AnyObject]] {
                    self.save(songArray)
                }
            } else {
                self.delegate?.dataManagerDidLoad?()
            }
        }
    }
    
    private func save(data: [[String : AnyObject]]) {
        Sync.changes(data, inEntityNamed: "SongEntity", dataStack: self.dataStack, completion: { (error) -> Void in
            self.delegate?.dataManagerDidLoad?()
            if error != nil {
                print(error?.localizedDescription)
            }
        })
    }
}