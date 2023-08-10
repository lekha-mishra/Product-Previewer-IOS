//
//  Animation.swift
//  ProductPreviewer
//
//  Created by IPH Technologies Pvt. Ltd. on 09/05/23.
//

import Foundation
import UIKit
class Animation{
    static let shared = Animation()
    var identifier: Int?
    func animateImageSize(xFront: CGFloat, yFront: CGFloat, image: UIImageView, xBack: CGFloat, yBack: CGFloat){
        UIView.animate(withDuration: 1.0, animations: {() -> Void in
            image.transform = CGAffineTransform(scaleX: xFront, y: yFront)
        }, completion: {_ in
            image.transform = CGAffineTransform(scaleX: xBack, y: yBack)
        })
    }
    
    func circleAnim(_ view: UIView, duration: CFTimeInterval, completion: @escaping() -> ()) {
        let maskDiameter = CGFloat(sqrtf(powf(Float(view.bounds.width), 2) + powf(Float(view.bounds.height), 2)))
        print(maskDiameter) //893
        let mask = CAShapeLayer()
        let animationId = "path"
        // Make a circular shape.
        mask.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: maskDiameter, height: maskDiameter), cornerRadius: maskDiameter / 2).cgPath
        mask.position = CGPoint(x: (view.bounds.width - maskDiameter) / 2, y: (view.bounds.height - maskDiameter) / 2)
        // Add as a mask to the parent layer.
        view.layer.mask = mask
        // Animate.
        let animation = CABasicAnimation(keyPath: animationId)
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        // Create a new path.
        let newPath = UIBezierPath(roundedRect: CGRect(x: maskDiameter / 2, y: maskDiameter / 2, width: 0, height: 0), cornerRadius: 0).cgPath
        if identifier == 1{
            // Set start and end values.
            animation.fromValue = newPath
            animation.toValue = mask.path
        }
        else{
            animation.fromValue = mask.path
            animation.toValue = newPath
        }
        // Start the animation.
        mask.add(animation, forKey: animationId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        completion()
        }
    }
    
    func changeColor(imageView: UIImageView, color: UIColor, value1: CFloat, value2: CFloat, value3: CFloat, value4: CFloat, value5: CFloat, value6: CFloat, alphaValueTop: CFloat, alphaValueBottom: CFloat){
        UIView.transition(with: imageView,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            let maskImage = UIImage(named: "layer")
            imageView.image = maskImage!.maskWithGradientColor(color: color,value1: CGFloat(value1), value2: CGFloat(value2), value3: CGFloat(value3), value4: CGFloat(value4), value5: CGFloat(value5), value6: CGFloat(value6), alphaValueTop: CGFloat(alphaValueTop), alphaValueBottom: CGFloat(alphaValueBottom))},
                          completion: nil)
    }
    
    func maskToWhite(imageView: UIImageView){
        UIView.transition(with: imageView,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: {
            let originalImage = imageView.image
       let tintedImage = originalImage?.withRenderingMode(.alwaysTemplate)
            imageView.image = tintedImage
            imageView.tintColor = UIColor.maskColor() },
                          completion: nil)
    }
}
