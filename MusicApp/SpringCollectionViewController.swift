//
//  SpringCollectionViewController.swift
//  MusicApp
//
//  Created by Alexsander  on 3/15/16.
//  Copyright © 2016 Alexsander Khitev. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import Sync
import DATAStack


class SpringCollectionViewController: UICollectionViewController, DataManagerDelegate {

    // MARK: - var and let
    private let reuseIdentifier = "SpringCell"
    private var dataManager: DataManager!
    private var songs = [SongEntity]()
    private var fetchResultController: NSFetchedResultsController!
    private var dataStack: DATAStack!
    private var requestControl: UIRefreshControl!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSubviews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        dataManager = DataManager()
        dataManager.download()
        dataManager.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - functions
    private func setSubviews() {
        requestControl = UIRefreshControl()
        requestControl.addTarget(self, action: "updateCollection", forControlEvents: .ValueChanged)
        collectionView?.addSubview(requestControl)
        collectionView?.alwaysBounceVertical = true
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1 ?? 0
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return songs.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! SpringCollectionViewCell
        // customization cell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.blackColor().CGColor
        
        let song = songs[indexPath.row]
    
        // Configure the cell
        if let author = song.author {
            cell.authorLabel?.text = author
        }
        if let title = song.label {
            cell.titleLabel.text = title
        }
    
        return cell
    }
}

// MARK: - model data
extension SpringCollectionViewController {
    func dataManagerDidLoad() {
        print("dataManagerDidLoad")
        let fetchRequest = NSFetchRequest(entityName: "SongEntity")
        let sortDescriptors = NSSortDescriptor(key: "author", ascending: true)
        fetchRequest.fetchLimit = 100
        fetchRequest.sortDescriptors = [sortDescriptors]
        dataStack = (UIApplication.sharedApplication().delegate as! AppDelegate).dataStack
        do {
            songs = (try dataStack.mainContext.executeFetchRequest(fetchRequest)) as! [SongEntity]
            requestControl.endRefreshing()
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.collectionView?.performBatchUpdates({ () -> Void in
                    self.collectionView?.reloadSections(NSIndexSet(index: 0))
                    }, completion: nil)
            })
//            collectionView?.reloadData()
        } catch {
            print("There is an error in dataManagerDidLoad")
        }
    }
    
    @objc private func updateCollection() {
        dataManager.download()
    }
}

// MARK: - delegate
extension SpringCollectionViewController {
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SpringCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize = UIScreen.mainScreen().bounds.size
        let width = screenSize.width / 2 - 4
        let height = width
        let returnedSize = CGSize(width: width, height: height)
        return returnedSize
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        let returnedValue: CGFloat = 8
        return returnedValue
    }

}
