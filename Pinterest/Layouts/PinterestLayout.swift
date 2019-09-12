/// Copyright (c) 2019 Razeware LLC
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

protocol PinterestLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heigthForPhotoAtIndex indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {

  // MARK: - Properties
  weak var delegate: PinterestLayoutDelegate?
  private let numberOfColumns = 2
  private let cellPadding: CGFloat = 6
  private var cache: [UICollectionViewLayoutAttributes] = []
  private var contentHeight: CGFloat = 0
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  // This method returns the width and height of the collection view’s contents. You must implement it to return the height and width of the entire collection view’s content, not just the visible content. The collection view uses this information internally to configure its scroll view’s content size.
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  // MARK: - Methods
  // Whenever a layout operation is about to take place, UIKit calls this method. It’s your opportunity to prepare and perform any calculations required to determine the collection view’s size and the positions of the items.
  override func prepare() {
    <#code#>
  }
  
  // In this method, you return the layout attributes for all items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes.
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    <#code#>
  }
  
  // This method provides on demand layout information to the collection view. You need to override it and return the layout attributes for the item at the requested indexPath.
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    <#code#>
  }
  
}
