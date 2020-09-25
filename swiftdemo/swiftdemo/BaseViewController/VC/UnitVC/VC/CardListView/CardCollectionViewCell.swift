//
//  CardCollectionViewCell.swift
//  swiftdemo
//
//  Created by qf on 2020/9/25.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
extension CGPoint{
    static func += (lhs: inout CGPoint, rhs: CGPoint){
        lhs = CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

public extension CardCollectionViewCell{
    @objc enum  SwipeDirection :Int {
        case none = 0
        case left = 1
        case right = 2
    }
}

protocol CardCellDelagate: NSObjectProtocol {
    func cardCell(_ cell: CardCollectionViewCell, willRemoveAt direction: CardCollectionViewCell.SwipeDirection)
    func cardCell(_ cell: CardCollectionViewCell, didRemoveAt direction: CardCollectionViewCell.SwipeDirection)
    func cardCell(_ cell: CardCollectionViewCell, didMoveAt point: CGPoint, direction: CardCollectionViewCell.SwipeDirection)
}


public class CardCollectionViewCell: UICollectionViewCell {
    private var originalTransform: CGAffineTransform = .identity
    private var currentPoint: CGPoint = .zero
    
    weak var delegate: CardCellDelagate?
    open weak var cardView: CardView!
    open var maxAngle: CGFloat = 0
    open var maxRemoveDistance: CGFloat = 0
    open var isPanAnimatedEnd: Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPanGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addPanGestureRecognizer()
    }

    private func addPanGestureRecognizer() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panGestureRecognizer(pan:)))
        self.addGestureRecognizer(pan)
    }
    
    @objc private func panGestureRecognizer(pan: UIPanGestureRecognizer) {
        guard self.cardView.isShowFirst(cell: self) else { return }
        switch pan.state {
        case .began:
            self.currentPoint = .zero
            self.originalTransform = self.transform
        case .changed:
            let movePoint = pan.translation(in: pan.view)
            self.didPanStateChanged(move: movePoint)
            pan.setTranslation(.zero, in: pan.view)
        case .ended:
            self.didPanStateEnded()
        default:
            self.restorePosition()
        }
    }
}
extension CardCollectionViewCell {
    func remove(swipe direction: SwipeDirection) {
        self.remove(direction: direction, isPan: false)
    }
}

fileprivate extension CardCollectionViewCell {
    func degreesToRadians(angle: CGFloat) -> CGFloat {
        return (angle / 180.0 * CGFloat.pi)
    }
    func transform(direction: SwipeDirection) -> CGAffineTransform {
        switch direction {
        case .left:
            return self.originalTransform.rotated(by: -degreesToRadians(angle: self.maxAngle))
        case .right:
            return self.originalTransform.rotated(by: degreesToRadians(angle: self.maxAngle))
        default: return self.originalTransform
        }
    }
    func endCenter(direction: SwipeDirection, view: UIView) -> CGPoint {
        let rect: CGRect = self.cardView.rectCardViewForCell(self)
        let centerY: CGFloat = view.center.y + rect.origin.y - view.frame.origin.y
        switch direction {
        case .left:
            let endCenterX = -(KScreenWidth*0.5 + self.frame.width)
            return CGPoint(x: endCenterX, y: centerY)
        case .right:
            let endCenterX = KScreenWidth*0.5 + self.frame.width*1.5
            return CGPoint(x: endCenterX, y: centerY)
        default: return .zero
        }
    }
    func didPanStateChanged(move point: CGPoint) {
        self.currentPoint += point
        var moveScale: CGFloat = self.currentPoint.x / self.maxRemoveDistance
        if abs(moveScale) > 1.0 {
            moveScale = (moveScale > 0) ? 1.0 : -1.0
        }
        let angle = degreesToRadians(angle: self.maxAngle) * moveScale
        let transRotation = self.originalTransform.rotated(by: angle)
        self.transform = transRotation.translatedBy(x: self.currentPoint.x, y: self.currentPoint.y)
        
        if (self.currentPoint.x < -self.maxRemoveDistance) {
            self.delegate?.cardCell(self, didMoveAt: self.currentPoint, direction: .left)
        }
        else if (self.currentPoint.x > self.maxRemoveDistance) {
            self.delegate?.cardCell(self, didMoveAt: self.currentPoint, direction: .right)
        }
        else {
            self.delegate?.cardCell(self, didMoveAt: self.currentPoint, direction: .none)
        }
    }
    func didPanStateEnded() {
        self.cardView.isUserInteractionEnabled = (false || !self.isPanAnimatedEnd)
        if (self.currentPoint.x < -self.maxRemoveDistance) {
            self.remove(direction: .left, isPan: true)
        }
        else if (self.currentPoint.x > self.maxRemoveDistance) {
            self.remove(direction: .right, isPan: true)
        }
        else {
            self.restorePosition()
        }
    }
    func restorePosition() {
        UIView.animate(
            withDuration: SpringDuration, delay: 0,
            usingSpringWithDamping: SpringWithDamping,
            initialSpringVelocity: SpringVelocity,
            options: .curveEaseOut,
            animations: {
                self.transform = self.originalTransform
        }, completion: { (finished) in
            self.cardView.isUserInteractionEnabled = true
        })
    }
    func didRemove(direction: SwipeDirection) {
        self.transform = self.originalTransform
        self.removeFromSuperview()
        self.delegate?.cardCell(self, didRemoveAt: direction)
    }
    func remove(direction: SwipeDirection, isPan stateEnded: Bool) {
        self.delegate?.cardCell(self, willRemoveAt: direction)
        let snapshotView = self.snapshotView(afterScreenUpdates: true) ?? UIView()
        snapshotView.transform = self.transform
        self.cardView.addSubview(snapshotView)
        let toCenter = self.endCenter(direction: direction, view: snapshotView)
        snapshotView.center = CGPoint(x: snapshotView.center.x, y: toCenter.y)
        self.didRemove(direction: direction)
        
        let toTransform: CGAffineTransform = self.transform(direction: direction)
        UIView.animateKeyframes(withDuration: DefaultDuration, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1.0) {
                snapshotView.center = toCenter
            }
            if !stateEnded {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    snapshotView.transform = toTransform
                }
            }
        }, completion: { (finished) in
            snapshotView.removeFromSuperview()
            self.cardView.isUserInteractionEnabled = true
        })
    }
}
