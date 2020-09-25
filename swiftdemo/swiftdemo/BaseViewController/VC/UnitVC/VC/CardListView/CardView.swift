//
//  CardView.swift
//  swiftdemo
//
//  Created by qf on 2020/9/25.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

 protocol CardViewDataSource: NSObjectProtocol{
    func numberOfItems(in cardView: CardView) -> Int
    
    func cardView(_ cardView: CardView, cellForItemAt indexPath: IndexPath) -> CardCollectionViewCell
}

@objc  public protocol CardViewDelegate: NSObjectProtocol {
   @objc func cardView(_ cardView: CardView, didSelectItemAt index: Int)
   @objc func cardView(_ cardView: CardView, willRemove cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection)
   @objc func cardView(_ cardView: CardView, didRemove cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection)
   @objc func cardView(_ cardView: CardView, didRemoveLast cell: CardCollectionViewCell, forItemAt index: Int, direction: CardCollectionViewCell.SwipeDirection)
   @objc func cardView(_ cardView: CardView, didDisplay cell: CardCollectionViewCell, forItemAt index: Int)
   @objc func cardView(_ cardView: CardView, didMove cell: CardCollectionViewCell, forItemAt index: Int, move point: CGPoint, direction: CardCollectionViewCell.SwipeDirection)
    
}

public class CardView: UIView {
     
    weak var dataSource: CardViewDataSource?
    weak var delegate: CardViewDelegate?
    private(set) var cardLayout: CardLayout!
    private var collectionView: UICollectionView!
    
    convenience init(frame: CGRect, cardLayout layout: CardLayout) {
        self.init(frame:frame)
        self.setCardLayout(cardLayout: layout)
    }
    
    func setCardLayout(cardLayout layout: CardLayout) {
        self.cardLayout = layout
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.cardLayout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.addSubview(self.collectionView)
    }

}
extension CardView {
    final func register<T: UICollectionViewCell>(classCellType: T.Type) {
        let cellID = String(describing: classCellType)
        self.collectionView.register(classCellType, forCellWithReuseIdentifier: cellID)
    }
    final func register<T: UICollectionViewCell>(nibCellType: T.Type) {
        let cellID = String(describing: nibCellType)
        let nib = UINib.init(nibName: cellID, bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: cellID)
    }
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let cellID = String(describing: cellType)
        let bareCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError(
                "Failed to dequeue a cell with identifier \(cellID) matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell beforehand"
            )
        }
        return cell
    }
    final func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        self.collectionView.performBatchUpdates({
        }) { [weak self] (finished) in
            self?.collectionView.setContentOffset(contentOffset, animated: animated)
        }
    }
    final func scrollToItem(at index: Int, animated: Bool) {
        if animated && index > 0 {
            let currentIndex: Int = Int(round(self.collectionView.contentOffset.y / self.collectionView.frame.height))
            if abs(currentIndex - index) > 1 {
                let offsetY: CGFloat = CGFloat(index - 1) * self.collectionView.frame.height
                self.setContentOffset(CGPoint(x: 0, y: offsetY), animated: false)
            }
        }
        let offsetY: CGFloat = CGFloat(index) * self.collectionView.frame.height
        self.setContentOffset(CGPoint(x: 0, y: offsetY), animated: animated)
    }
    final func removeTopCardViewCell(swipe direction: CardCollectionViewCell.SwipeDirection) {
        let index: Int = Int(round(self.collectionView.contentOffset.y / self.collectionView.frame.height))
        let topCell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? CardCollectionViewCell
        topCell?.remove(swipe: direction)
    }
    final func invalidateLayout() {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    final func reloadData() {
        self.collectionView.reloadData()
    }
    final func isShowFirst(cell: CardCollectionViewCell) -> Bool {
        let index = self.collectionView.indexPath(for: cell)?.item ?? 0
        let firstIndex = Int(ceil(self.collectionView.contentOffset.y/self.collectionView.frame.height))
        return index == firstIndex
    }
    final func rectCardViewForCell(_ cell: CardCollectionViewCell) -> CGRect {
        return self.collectionView.convert(cell.frame, to: self)
    }
}

extension CardView: UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - UICollectionViewDataSource
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.numberOfItems(in: self) ?? 0
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dataSource?.cardView(self, cellForItemAt: indexPath)
        cell?.isPanAnimatedEnd = self.cardLayout.isPanAnimatedEnd
        cell?.maxRemoveDistance = self.cardLayout.maxRemoveDistance
        cell?.maxAngle = self.cardLayout.maxAngle
        cell?.cardView = self
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    // MARK: - UICollectionViewDelegate
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (delegate?.responds(to: #selector(delegate?.cardView(_:didSelectItemAt:))) ?? false) {
            self.delegate?.cardView(self, didSelectItemAt: indexPath.item)
        }
    }
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (delegate?.responds(to: #selector(delegate?.cardView(_:didDisplay:forItemAt:))) ?? false) {
            self.delegate?.cardView(self, didDisplay: cell as! CardCollectionViewCell, forItemAt: indexPath.item)
        }
    }
}

extension CardView: UIScrollViewDelegate {
    // MARK: - UIScrollViewDelegate
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard self.cardLayout.isRepeat else { return }
        let index: Int = Int(round(scrollView.contentOffset.y / scrollView.frame.height))
        let lastIndex = (self.dataSource?.numberOfItems(in: self) ?? 0)
        if index == lastIndex {
            self.scrollToItem(at: 0, animated: false)
        }
    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard self.cardLayout.isRepeat else { return }
        let index: Int = Int(round(scrollView.contentOffset.y / scrollView.frame.height))
        let lastIndex = (self.dataSource?.numberOfItems(in: self) ?? 0)
        if index == lastIndex {
            self.scrollToItem(at: 0, animated: false)
        }
    }
}

extension CardView: CardCellDelagate {
    func cardCell(_ cell: CardCollectionViewCell, willRemoveAt direction: CardCollectionViewCell.SwipeDirection) {
        let index = self.collectionView.indexPath(for: cell)?.item ?? 0
        if (delegate?.responds(to: #selector(delegate?.cardView(_:willRemove:forItemAt:direction:))) ?? false) {
            self.delegate?.cardView(self, willRemove: cell, forItemAt: index, direction: direction)
        }
    }
    func cardCell(_ cell: CardCollectionViewCell, didRemoveAt direction: CardCollectionViewCell.SwipeDirection) {
        let index = self.collectionView.indexPath(for: cell)?.item ?? 0
        let lastIndex = (self.dataSource?.numberOfItems(in: self) ?? 0) - 1

        if self.cardLayout.isRepeat {
            self.scrollToItem(at: index + 1, animated: true)
        }
        else {
            if index <= lastIndex {
                self.scrollToItem(at: index + 1, animated: true)
            }
        }
        
        if (delegate?.responds(to: #selector(delegate?.cardView(_:didRemove:forItemAt:direction:))) ?? false) {
            self.delegate?.cardView(self, didRemove: cell, forItemAt: index, direction: direction)
        }
        if  index == lastIndex {
            if (delegate?.responds(to: #selector(delegate?.cardView(_:didRemoveLast:forItemAt:direction:))) ?? false) {
                self.delegate?.cardView(self, didRemoveLast: cell, forItemAt: index, direction: direction)
            }
        }
    }
    func cardCell(_ cell: CardCollectionViewCell, didMoveAt point: CGPoint, direction: CardCollectionViewCell.SwipeDirection) {
        if (delegate?.responds(to: #selector(delegate?.cardView(_:didMove:forItemAt:move:direction:))) ?? false) {
            let index = self.collectionView.indexPath(for: cell)?.item ?? 0
            self.delegate?.cardView(self, didMove: cell, forItemAt: index, move: point, direction: direction)
        }
    }
}
