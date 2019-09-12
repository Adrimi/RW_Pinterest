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
  private let numberOfColumns = 3
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
  // To be sure, prepare() function can be launched while changing of UICollectionView bounds, in case of "rotation" of the device or adding/removing items for example. Then, it is crucial to recalculate values!!!
  override func prepare() {
    
    // calculate the layout attributes if cache is empty and the collection view exists.
    guard cache.isEmpty, let collectionView = collectionView else { return }
    
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    var xOffset: [CGFloat] = []
    
    for column in 0..<numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    
    // initialize each value in yOffset to 0, since this is the offset of the first item in each column.
    var column = 0
    var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
    
    // Loop through all the items in the first section since this particular layout has only one section.
    for item in 0..<collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      
      let photoHeigth = delegate?.collectionView(collectionView, heigthForPhotoAtIndex: indexPath) ?? 180
      
      let heigth = cellPadding * 2 + photoHeigth
      let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: heigth)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      // setting layout from calculated values
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      
      // save changes for reusing, to ommit unnecessary calculation and reduca CPU usage
      cache.append(attributes)
      
      // Expand contentHeight to account for the frame of the newly calculated item. Then, advance the yOffset for the current column based on the frame.
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + heigth
      
      // Finally, advance the column so the next item will be placed in the next column.
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
      
    }
  }
  
  // In this method, you return the layout attributes for all items inside the given rectangle. You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes.
  // This method will be called after prepare(), to ensure, what elements are currently visible in the given rectangle
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // loop through the cache and look for items in the rectangle
    for attribute in cache {
      if attribute.frame.intersects(rect) {
        visibleLayoutAttributes.append(attribute)
      }
    }
    
    return visibleLayoutAttributes
  }
  
  // This method provides on demand layout information to the collection view. You need to override it and return the layout attributes for the item at the requested indexPath.
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
  
}
