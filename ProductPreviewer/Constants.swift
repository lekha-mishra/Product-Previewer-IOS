//
//  Constants.swift
//  ProductPreviewer
//
//  Created by IPH Technologies Pvt. Ltd. on 29/05/23.
//

import Foundation
import UIKit
class Constants{
    static let shared = Constants()
    let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    let size = ["6","7","8","9"]
    let dashHeight: CGFloat = 1.0
    let dashWidth: CGFloat = 99.0
    let numberFont = UIFont.boldSystemFont(ofSize: 40)
    let relativeConstant: CGFloat = 0.022
}

extension UIColor
{
    class func viewBackgroungColor() -> UIColor
    {
        return UIColor(red: 0.145, green: 0.588, blue: 0.745, alpha: 1.0)
    }

    class func viewGradientColorOne() -> UIColor
    {
        return  UIColor(red: 0.592, green: 0.686, blue: 0.725, alpha: 1.0)
    }
    class func viewGradientColorTwo() -> UIColor
    {
        return UIColor(red: 0.824, green: 0.902, blue: 0.933, alpha: 1.0)
    }
    class func viewGradientColorThree() -> UIColor
    {
        return UIColor(red: 0.490, green: 0.702, blue: 0.780, alpha: 1.0)
    }
    class func viewGradientColorFour() -> UIColor
    {
        return UIColor(red: 0.976, green: 0.706, blue: 0.753, alpha: 1.0)
    }
    class func cartButtonHelddownColor() -> UIColor{
        return UIColor(red: 107, green: 132, blue: 241, alpha: 0)
    }
    class func maskColor() -> UIColor{
        return UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    }
}
//MARK: gradient
extension UIImage {
    func maskWithGradientColor(color: UIColor, value1: CGFloat, value2: CGFloat, value3: CGFloat, value4: CGFloat, value5: CGFloat, value6: CGFloat, alphaValueTop: CGFloat, alphaValueBottom: CGFloat) -> UIImage? {
        let maskImage = self.cgImage
        let width = self.size.width
        let height = self.size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let bitmapContext = CGContext(data: nil,
                                      width: Int(width),
                                      height: Int(height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: 0,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo.rawValue)
        let locations:[CGFloat] = [0.0, 1.0]
        let bottom = UIColor(red: value1, green: value2, blue: value3, alpha: 1).cgColor
        let top = UIColor(red: value4, green: value5, blue: value6, alpha: 0).cgColor
        let colors = [bottom, top] as CFArray
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        let startPoint = CGPoint(x: width/2, y: 0)
        let endPoint = CGPoint(x: width/2, y: height)
        bitmapContext!.clip(to: bounds, mask: maskImage!)
        bitmapContext!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        if let cImage = bitmapContext!.makeImage() {
            let coloredImage = UIImage(cgImage: cImage)
            return coloredImage
        }
        else  {
            return nil
        }
    }
}

