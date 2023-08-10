//
//  ViewController.swift
//  ProductPreviewer
//
//  Created by IPH Technologies Pvt. Ltd. on 28/04/23.
//

import UIKit
class ViewController: UIViewController {
  
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var sizePickerView: UIPickerView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var redColorView: UIView!
    @IBOutlet weak var blueColorView: UIView!
    @IBOutlet weak var greenColorView: UIView!
    @IBOutlet weak var blackColorView: UIView!
    @IBOutlet weak var whiteColorView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var layerImageView: UIImageView!
    @IBOutlet weak var outerCircularView: UIView!
    @IBOutlet weak var middleCircularView: UIView!
    @IBOutlet weak var innerCircularView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        descriptionLabel.font = descriptionLabel.font.withSize(self.view.frame.height*Constants.shared.relativeConstant)
        descriptionLabel.minimumScaleFactor = 0.5;
        descriptionLabel.adjustsFontSizeToFitWidth = true;
    }
    
    @IBAction func detailButtonAction(_ sender: UIButton) {
        Animation.shared.identifier = 1
        detailView.isHidden = false
        changeBackgroundOfView()
        Animation.shared.circleAnim(detailView, duration: 0.5,completion: {
            DispatchQueue.main.async {
                self.detailView.layer.sublayers!.remove(at: 0)
                self.detailView.backgroundColor = UIColor.viewBackgroungColor()
                    }
        })
    }
    
    @IBAction func addToCartAction(_ sender: UIButton) {
        Animation.shared.identifier = 0
        Animation.shared.circleAnim(detailView, duration: 0.5,
                                    completion: {
        DispatchQueue.main.async {
           self.detailView.isHidden = true
            }
        })
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        detailView.isHidden = true
    }
    
    func setupUI(){
        detailView.isHidden = true
        detailButton.layer.cornerRadius = detailButton.layer.bounds.width / 2
        //for making colorviews circular with white border
        colorViewUI(colorView: redColorView)
        colorViewUI(colorView: blueColorView)
        colorViewUI(colorView: greenColorView)
        colorViewUI(colorView: blackColorView)
        colorViewUI(colorView: whiteColorView)
        //circularView UI design
        colorViewUI(colorView: outerCircularView)
        colorViewUI(colorView: middleCircularView)
        colorViewUI(colorView: innerCircularView)
        //cartButton UI design
        cartButton.layer.cornerRadius = cartButton.frame.size.height/2 //Ht/2
        cartButton.layer.borderWidth = 2
        cartButton.layer.borderColor = UIColor.white.cgColor
        cartButton.titleLabel?.font = .systemFont(ofSize: 15)
        self.cartButton.frame.size.height = 100
        cartButton.addTarget(self, action: #selector(self.heldDown), for: .touchDown)
        //closeButton UI design
        closeButton.layer.cornerRadius = closeButton.layer.bounds.width / 2
        closeButton.layer.shadowColor = UIColor.black.cgColor
        closeButton.layer.shadowOpacity = 0.2
        closeButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        closeButton.layer.shadowRadius = 4.0
        closeButton.layer.masksToBounds = false
        //for recognizing the user tap on colorviews
        let gestureRed = UITapGestureRecognizer(target: self, action:  #selector (self.changeColorToRed (_:)))
        self.redColorView.addGestureRecognizer(gestureRed)
        let gestureBlue = UITapGestureRecognizer(target: self, action:  #selector (self.changeColorToBlue (_:)))
        self.blueColorView.addGestureRecognizer(gestureBlue)
        let gestureGreen = UITapGestureRecognizer(target: self, action:  #selector (self.changeColorToGreen(_:)))
        self.greenColorView.addGestureRecognizer(gestureGreen)
        let gestureBlack = UITapGestureRecognizer(target: self, action:  #selector (self.changeColorToBlack (_:)))
        self.blackColorView.addGestureRecognizer(gestureBlack)
        let gestureWhite = UITapGestureRecognizer(target: self, action:  #selector (self.changeColorToWhite (_:)))
        self.whiteColorView.addGestureRecognizer(gestureWhite)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    func changeBackgroundOfView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = detailView.bounds
        gradientLayer.colors = [
            UIColor.viewGradientColorOne().cgColor,
            UIColor.viewGradientColorTwo().cgColor,
            UIColor.viewGradientColorThree().cgColor,
            UIColor.viewGradientColorFour().cgColor]
            detailView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func colorViewUI(colorView: UIView){
        if colorView != outerCircularView && colorView != middleCircularView  && colorView != innerCircularView  {
            colorView.layer.cornerRadius = colorView.layer.bounds.width / 2
            colorView.layer.borderWidth = 2
            colorView.layer.borderColor = UIColor.white.cgColor
        }
        else{
            colorView.layer.cornerRadius = colorView.layer.bounds.width / 2
        }
    }
    //Functions for changing the color of specific part of image.
    @objc func changeColorToRed(_ sender:UITapGestureRecognizer) {
        Animation.shared.changeColor(imageView: layerImageView, color: UIColor.red, value1: 1, value2: 0, value3: 0, value4: 1, value5: 1, value6: 1, alphaValueTop: 0, alphaValueBottom: 1)
    }
    
    @objc func changeColorToBlue(_ sender:UITapGestureRecognizer){
        Animation.shared.changeColor(imageView: layerImageView, color: UIColor.blue, value1: 0, value2: 0, value3: 1, value4: 0, value5: 0, value6: 1, alphaValueTop: 1, alphaValueBottom: 0)
    }
    
    @objc func changeColorToGreen(_ sender:UITapGestureRecognizer) {
        Animation.shared.changeColor(imageView: layerImageView, color: UIColor.green, value1: 0, value2: 1, value3: 0, value4: 1, value5: 0, value6: 0, alphaValueTop: 0, alphaValueBottom: 1)
    }
    
    @objc func changeColorToBlack(_ sender:UITapGestureRecognizer) {
        Animation.shared.changeColor(imageView: layerImageView, color: UIColor.black, value1: 0, value2: 0, value3: 0, value4: 0, value5: 0, value6: 0, alphaValueTop: 0, alphaValueBottom: 1)
    }
    
    @objc func changeColorToWhite(_ sender:UITapGestureRecognizer) {
        Animation.shared.maskToWhite(imageView: layerImageView)
    }
    
    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        // Check if the tap was outside of the detailView
        let location = gestureRecognizer.location(in: detailView)
        if !detailView.point(inside: location, with: nil) {
            detailView.isHidden = true
        }
    }
    //target functions
    @objc func heldDown() {
        //
        cartButton.backgroundColor = UIColor.cartButtonHelddownColor()
        cartButton.tintColor = .white
    }
}
//MARK: UIPickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.shared.size.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 210, height: 30))
        let dashView = UIView(frame: CGRect(x: 0, y: (containerView.frame.height - Constants.shared.dashHeight) / 2, width: Constants.shared.dashWidth, height: Constants.shared.dashHeight))
        dashView.backgroundColor = UIColor.white
        containerView.addSubview(dashView)
        let height =  (containerView.frame.height - Constants.shared.dashHeight) / 2
        if row != (Constants.shared.size.count - 1) {
            for i in 1...5 {
                let dashView = UIView(frame: CGRect(x: 0, y: (CGFloat(10 * i) + height), width: Constants.shared.dashWidth - 20, height: Constants.shared.dashHeight))
                dashView.backgroundColor = UIColor.white
                containerView.addSubview(dashView)
            }
        }
        let numberLabel = UILabel(frame: CGRect(x: Constants.shared.dashWidth + 10, y: 0, width: 70, height: containerView.frame.height))
        numberLabel.textAlignment = .center
        numberLabel.textColor = .white
        numberLabel.font = Constants.shared.numberFont
        numberLabel.text = "\(Constants.shared.size[row])"
        containerView.addSubview(numberLabel)
        return containerView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(Constants.shared.size[row])
        let sizeSelected = Constants.shared.size[row]
        switch sizeSelected{
        case "6":
            Animation.shared.animateImageSize(xFront: 1.05, yFront: 1.05, image: layerImageView, xBack: 1.03, yBack: 1.03)
            Animation.shared.animateImageSize(xFront: 1.05, yFront: 1.05, image: productImageView, xBack: 1.03, yBack: 1.03)
        case "7":
            Animation.shared.animateImageSize(xFront: 1.08, yFront: 1.08, image: layerImageView, xBack: 1.06, yBack: 1.06)
            Animation.shared.animateImageSize(xFront: 1.08, yFront: 1.08, image: productImageView, xBack: 1.06, yBack: 1.06)
        case "8":
            Animation.shared.animateImageSize(xFront: 1.11, yFront: 1.11, image: layerImageView, xBack: 1.08, yBack: 1.08)
            Animation.shared.animateImageSize(xFront: 1.11, yFront: 1.11, image: productImageView, xBack: 1.08, yBack: 1.08)
        case "9":
            Animation.shared.animateImageSize(xFront: 1.14, yFront: 1.14, image: layerImageView, xBack: 1.12, yBack: 1.12)
            Animation.shared.animateImageSize(xFront: 1.14, yFront: 1.14,  image: productImageView, xBack: 1.12, yBack: 1.12)
        default:
            print("invalid")
        }
    }
}
