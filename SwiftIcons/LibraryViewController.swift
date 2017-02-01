//  The MIT License (MIT)
//
//  Copyright © 2017 Saurabh Rane
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public extension UILabel {

    public func setIcons(icon1: FontType?, icon1Color: UIColor = .black, icon1BackgroundColor: UIColor = .clear, icon2: FontType?, icon2Color: UIColor = .black, icon2BackgroundColor: UIColor = .clear, iconSize: CGFloat? = nil) {
        
        let label1 = UILabel()
        label1.frame = CGRect(x: self.frame.width/2-40, y: self.frame.height/2-20, width: 40, height: 40)
        label1.textAlignment = .center
        label1.setIcon(icon: icon1!, iconSize: iconSize ?? 20, color: icon1Color, bgColor: icon1BackgroundColor)
        label1.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        
        let label2 = UILabel()
        label2.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2-20, width: 40, height: 40)
        label2.textAlignment = .center
        label2.setIcon(icon: icon2!, iconSize: iconSize ?? 20, color: icon2Color, bgColor: icon2BackgroundColor)
        label2.layer.borderColor = icon2Color.cgColor
        label2.layer.borderWidth = 2
        label2.layer.masksToBounds = true
        label2.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        
        self.addSubview(label1)
        self.addSubview(label2)
    }
    
    public func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        self.layer.mask = maskLayer
    }    
}

private let reuseIdentifier = "cell"

class LibraryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var topBackgroundColors = ["e74c3c", "e67e22", "f1c40f", "2ecc71", "1abc9c", "3498db", "9b59b6", "E4ACCF", "95a5a6", "34495e", "6c6998"]
    var bottomBackgroundColors = ["c0392b", "d35400", "f39c12", "27ae60", "16a085", "2980b9", "8e44ad", "B68AA5", "7f8c8d", "2c3e50", "8781bd"]
    var objects = ["UIImage", "UIImageView", "UILabel", "UIButton", "UISegmentedControl", "UITabBarItem", "UISlider", "UIBarButtonItem", "UIViewController", "UITextField", "UIStepper"]
    var objectNames = ["Image", "Image View", "Label", "Button", "Segmented Control", "Tab Bar Item", "Slider", "Item", "View Controller", "Text", "Stepper"]
    var icons: [FontType] = [.ionicons(.images), .fontAwesome(.pictureO), .fontAwesome(.tag), .ionicons(.iosCircleFilled), .fontAwesome(.pictureO), .ionicons(.iosStar), .ionicons(.iosToggle), .fontAwesome(.pictureO), .ionicons(.iphone), .fontAwesome(.ban), .fontAwesome(.ban)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "justlogo")
        navigationItem.titleView = imageView

        let font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        let black: UIColor = .black
        let attributes = [NSFontAttributeName : font!, NSForegroundColorAttributeName: black]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationItem.hidesBackButton = true

        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        let spacing = (screenWidth-300)/4
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView!.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return objects.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as UICollectionViewCell
    
        // Configure the cell
        
        let topLabel = cell.viewWithTag(1) as! UILabel
        topLabel.roundCorners(corners: [.topLeft, .topRight], radius: 5)

        if indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 7 || indexPath.row == 9 {
            topLabel.text = objectNames[indexPath.row]
            topLabel.backgroundColor = UIColor.init(hex: topBackgroundColors[indexPath.row])

        } else if indexPath.row == 4 {

            topLabel.backgroundColor = UIColor.init(hex: topBackgroundColors[indexPath.row])
            topLabel.setIcons(icon1: .emoji(.digitOne), icon1Color: UIColor.init(hex: topBackgroundColors[indexPath.row]), icon1BackgroundColor: .white, icon2: .emoji(.digitTwo), icon2Color: .white, icon2BackgroundColor: .clear, iconSize: 30)
            
        } else if indexPath.row == 10 {
            
            topLabel.backgroundColor = UIColor.init(hex: topBackgroundColors[indexPath.row])
            topLabel.setIcons(icon1: .emoji(.minus), icon1Color: UIColor.init(hex: topBackgroundColors[indexPath.row]), icon1BackgroundColor: .white, icon2: .emoji(.plus), icon2Color: .white, icon2BackgroundColor: .clear, iconSize: 30)

        } else {
            topLabel.setIcon(icon: icons[indexPath.row], iconSize: 30, color: .white, bgColor: UIColor.init(hex: topBackgroundColors[indexPath.row]))
        }

        
        let bottomLabel = cell.viewWithTag(2) as! UILabel
        bottomLabel.text = objects[indexPath.row]
        bottomLabel.backgroundColor = UIColor.init(hex: bottomBackgroundColors[indexPath.row])
        bottomLabel.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "objectSelectionSegue") {
            let viewController = segue.destination as! ObjectsDetailsViewController
            let indexPath = (collectionView?.indexPathsForSelectedItems?[0])! as IndexPath
            viewController.index = indexPath.row
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
