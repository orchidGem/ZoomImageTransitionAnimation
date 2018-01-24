/// Copyright (c) 2017 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class MaxiSongCardViewController: UIViewController, SongSubscriber {

  // MARK: - Properties
  let cardCornerRadius: CGFloat = 10
  var currentSong: Song?
  let primaryDuration = 4.0 // set to 0.5 when ready
  let backingImageEdgeInset: CGFloat = 15.0
  
  //scroller
  @IBOutlet weak var scrollView: UIScrollView!
  //this gets colored white to hide the background.
  //It has no height so doesnt contribute to the scrollview content
  @IBOutlet weak var stretchySkirt: UIView!
  
  //cover image
  @IBOutlet weak var coverImageContainer: UIView!
  @IBOutlet weak var coverArtImage: UIImageView!
  @IBOutlet weak var dismissChevron: UIButton!
  //add cover image constraints here
  
  //backing image
  var backingImage: UIImage?
  @IBOutlet weak var backingImageView: UIImageView!
  @IBOutlet weak var dimmerLayer: UIView!
  //add backing image constraints here
  @IBOutlet weak var backingImageTopInset : NSLayoutConstraint!
  @IBOutlet weak var backingImageLeadingInset : NSLayoutConstraint!
  @IBOutlet weak var backingImageTrailingInset : NSLayoutConstraint!
  @IBOutlet weak var backingImageBottomInset : NSLayoutConstraint!
 
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - View Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()

    modalPresentationCapturesStatusBarAppearance = true //allow this VC to control the status bar appearance
    modalPresentationStyle = .overFullScreen //dont dismiss the presenting view controller when presented
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    backingImageView.image = backingImage
   
    scrollView.contentInsetAdjustmentBehavior = .never //dont let Safe Area insets affect the scroll view
    
    //DELETE THIS LATER
    scrollView.isHidden = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    animateBackingImageIn()
  }
}

// MARK: - IBActions
extension MaxiSongCardViewController {

  @IBAction func dismissAction(_ sender: Any) {
    self.dismiss(animated: false)
  }
}

// background image animation
extension MaxiSongCardViewController {
  private func configureBackingImageInPosition(presenting: Bool) {
    let edgeInset: CGFloat = presenting ? backingImageEdgeInset : 0
    let dimmerAlpha: CGFloat = presenting ? 0.3 : 0
    let cornerRadius: CGFloat = presenting ? cardCornerRadius : 0
    
    backingImageLeadingInset.constant = edgeInset
    backingImageTrailingInset.constant = edgeInset
    let aspectRatio = backingImageView.frame.height / backingImageView.frame.width
    backingImageTopInset.constant = edgeInset * aspectRatio
    backingImageBottomInset.constant = edgeInset * aspectRatio
    
    //2.
    dimmerLayer.alpha = dimmerAlpha
    
    //3.
    backingImageView.layer.cornerRadius = cornerRadius
  }
  
  //4,
  private func animateBackingImage(presenting: Bool) {
    UIView.animate(withDuration: primaryDuration) {
      self.configureBackingImageInPosition(presenting: presenting)
      self.view.layoutIfNeeded() // IMPORTANT!
    }
  }
  
  //5.
  func animateBackingImageIn() {
    animateBackingImage(presenting: true)
  }
  
  func animateBackingImageOut() {
    animateBackingImage(presenting: false)
  }
}
