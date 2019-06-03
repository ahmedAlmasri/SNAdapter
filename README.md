<img src="https://github.com/ahmedalmasri/SNAdapter/blob/master/images/Banner.png?raw=true"></img>

A declarative type-safe framework for building fast and flexible lists with TableView & CollectionView, No more delegates and datasource. Just a fully type-safe declarative content approach

[![CI Status](https://img.shields.io/travis/ahmedAlmasri/SNAdapter.svg?style=flat)](https://travis-ci.org/ahmedAlmasri/SNAdapter)
[![Version](https://img.shields.io/cocoapods/v/SNAdapter.svg?style=flat)](https://cocoapods.org/pods/SNAdapter)
[![License](https://img.shields.io/cocoapods/l/SNAdapter.svg?style=flat)](https://cocoapods.org/pods/SNAdapter)
[![Platform](https://img.shields.io/cocoapods/p/SNAdapter.svg?style=flat)](https://cocoapods.org/pods/SNAdapter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Using

**Step 1**: Import the `SNAdapter` module in swift.

```swift
import SNAdapter
```
# TableView 


**Step 1**:   declare a new class or struct conform from `SNCellableModel`

```swift

struct MyModel: SNCellableModel {

  let title: String
}

```

**Step 2**:  declare a new `UITableViewCell`  conform from `SNCellable`

```swift

class MyCell: UITableViewCell, SNCellable {

  func configure(_ object: SNCellableModel?) {
    guard let myModel = object as? MyModel else { return }

    self.textLabel?.text = myModel.title
  }

}

```
**Step 3**: Take a reference to `SNTableViewSection`  and `SNTableViewAdapter` into your controller.

```swift
 private var mySection: SNTableViewSection<MyModel, MyCell>!
 private var myAdapter: SNTableViewAdapter!
```
**Step 4**: Initialize the `SNTableViewSection`  and `SNTableViewAdapter` in your viewDidLoad .

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  ///....
  
  // MARK: - call setup section

  setupMySection()
  
  ///...
}

private func setupMySection() {

 mySection = SNTableViewSection<MyModel, MyCell>(items: getMyListData())
 myAdapter = SNTableViewAdapter(sections: [mySection])
 myTableView.setAdapter(myAdapter)
 
}

private func getMyListData() -> [MyModel] {

return [MyModel(title: "Item 1"), MyModel(title: "Item 2")]

}

```
## More Example 

* [Pagination (Load More) Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/TableView/Paging)
* [Sections Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/TableView/Sections)
* [Actions Delegate Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/TableView/ActionDelegate)


# CollectionView 



**Step 1**:  declare new `UICollectionViewCell`  inherent form `SNCellable`

```swift

class MyCell: UICollectionViewCell, SNCellable {

 @IBOutlet weak var titleLabel: UILabel!
 
func configure(_ object: SNCellableModel?) {
guard let myModel = object as? MyModel else { return }

  titleLabel.text = myModel.title
}

}

```
**Step 2**: Take a reference to `SNCollectionViewSection`  and `SNCollectionViewAdapter` into your controller.

```swift
private var mySection: SNCollectionViewSection<MyModel, MyCell>!
private var myAdapter: SNCollectionViewAdapter!
```
**Step 3**: Initialize the `SNCollectionViewSection`  and `SNCollectionViewAdapter` in your viewDidLoad .

```swift
override func viewDidLoad() {
super.viewDidLoad()
///....

// MARK: - call setup section

setupMySection()

///...
}

private func setupMySection() {

mySection = SNCollectionViewSection<MyModel, MyCell>(items: getMyListData())
myAdapter = SNCollectionViewAdapter(sections: [mySection])
myCollectionView.setAdapter(myAdapter)

}

private func getMyListData() -> [MyModel] {

return [MyModel(title: "Item 1"), MyModel(title: "Item 2")]

}

```
## More Example 

* [Pagination (Load More) Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/TableView/Paging)
* [Header  Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/CollectionView/Header)
* [Actions Delegate Example](https://github.com/ahmedAlmasri/SNAdapter/blob/master/Example/SNAdapter/TableView/ActionDelegate)


## Requirements
* Swift 4.2+
* Xcode 10.0+
* iOS 11.0+

## Installation

SNAdapter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SNAdapter'
```

## Author

ahmedAlmasri, ahmed.almasri@ymail.com

## License

SNAdapter is available under the MIT license. See the LICENSE file for more info.
