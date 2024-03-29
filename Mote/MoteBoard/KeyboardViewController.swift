//
//  KeyboardViewController.swift
//  MoteBoard
//
//  Created by Ben on 10/10/14.
//  Copyright (c) 2014 Ben. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

  @IBOutlet var nextKeyboardButton: UIButton!

  // TODO: add different keyboard views
  // in controller variables, and
  // remove them with [self.namedView removeFromSuperview];
  var mainKeyboard: UIView!
  var numKeyboard: UIView!
  var symKeyboard: UIView!
  var viewHeight: CGFloat!
  var viewWidth: CGFloat!

  override func updateViewConstraints() {
      super.updateViewConstraints()
  
      // Add custom view sizing constraints here
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // Need to use viewDidAppear;
  // otherwise input.bounds gives incorrect values

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    setBounds()
    addMainKeyboard()
  }
  
  func setBounds() {
    viewHeight = self.inputView.bounds.height
    viewWidth = self.inputView.bounds.width
  }
  
//  func keyboardBuilder(rows: [Array]) {
//    var keyboardView = UIView(frame: CGRectMake(0, 0, viewWidth, viewHeight))
//    
//    let buttonTitles1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
//    let buttonTitles2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
//    let buttonTitles3 = ["△", "Z", "X", "C", "V", "B", "N", "M", "◁"]
//    let buttonTitles4 = ["nums", "CK", "SPACE", "RETURN"]
//    // CK = change keyboard
//    
//    var rowViews = Array<UIView>
//    
//    for row in rows {
//      keyboardView.addSubview(createRowOfButtons(row))
//      row.setTranslatesAutoresizingMaskIntoConstraints(false)
//      rowViews.append(row)
//    }
//    
//    addConstraintsToInputView(keyboardView, rowViews: rowViews)
//    
//    return keyboardView
//  }
//  
//  func buildNumkeyboard() -> UIView {
//    var mainKeyboard = UIView(frame: CGRectMake(0, 0, self.inputView.bounds.width, self.inputView.bounds.height))
//  }

  func buildMainKeyboard() -> UIView{
    var mainKeyboard = UIView(frame: CGRectMake(0, 0, viewWidth, viewHeight))

    let buttonTitles1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
    let buttonTitles2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
    let buttonTitles3 = ["△", "Z", "X", "C", "V", "B", "N", "M", "◁"]
    let buttonTitles4 = ["nums", "CK", "SPACE", "RETURN"]
    // CK = change keyboard

    var row1 = createRowOfButtons(buttonTitles1)
    var row2 = createRowOfButtons(buttonTitles2)
    var row3 = createRowOfButtons(buttonTitles3)
    var row4 = createRowOfButtons(buttonTitles4)
    
    mainKeyboard.addSubview(row1)
    mainKeyboard.addSubview(row2)
    mainKeyboard.addSubview(row3)
    mainKeyboard.addSubview(row4)
    
    row1.setTranslatesAutoresizingMaskIntoConstraints(false)
    row2.setTranslatesAutoresizingMaskIntoConstraints(false)
    row3.setTranslatesAutoresizingMaskIntoConstraints(false)
    row4.setTranslatesAutoresizingMaskIntoConstraints(false)
    
    addConstraintsToInputView(mainKeyboard, rowViews: [row1, row2, row3, row4])

    return mainKeyboard
  }
  
  func addMainKeyboard() {
    self.mainKeyboard = buildMainKeyboard()
    self.view.addSubview(self.mainKeyboard)
  }

  func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
    var buttons = [UIButton]()
    var keyboardRowView = UIView(frame: CGRectMake(0, 0, 320, 50))
    // Loop though to create buttons and add subviews to KeyboardRow
    
    for buttonTitle in buttonTitles{
      let button = createButtonWithTitle(buttonTitle)
      buttons.append(button)
      keyboardRowView.addSubview(button)
    }
    
    addIndividualButtonConstraints(buttons, mainView: keyboardRowView)
    
    return keyboardRowView
  }
  
  func createButtonWithTitle(title: String) -> UIButton {
      let button = UIButton.buttonWithType(.System) as UIButton
      button.frame = CGRectMake(0, 0, 20, 20)
      button.setTitle(title, forState: .Normal)
      button.sizeToFit()
      button.setTranslatesAutoresizingMaskIntoConstraints(false)
      button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)

      button.titleLabel?.font = UIFont.systemFontOfSize(15)
      button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)

      button.addTarget(self, action: "didTapButton:", forControlEvents: .TouchUpInside)
      
      return button
  }

  func didTapButton(sender: AnyObject?) {
    let button = sender as UIButton
    
    var proxy = textDocumentProxy as UITextDocumentProxy
    
    NSLog(" height: \(self.view.frame.height) width: \(self.view.frame.width)")
    
    if let title = button.titleForState(.Normal) {
      switch title {
      case "◁":
        proxy.deleteBackward()
      case "RETURN":
        proxy.insertText("\n")
      case "SPACE":
        proxy.insertText(" ")
      case "CK":
        self.advanceToNextInputMode()
      default:
        proxy.insertText(title)
      }
    }
  }
  
  // TODO: Function to switch to symKeyboard
  // 1. Remove top two rows on keyboard
  // 2. Replace top two rows with num buttons
  // 3. shift/num button changes state
  
  // TODO: Function to switch to numKeyboard
  // 1. Remove top three rows on keyboard
  // 2. Replace top three rows with num buttons
  // 3. shift button changes to switch to syms button
  
  // TODO: Numbers button pressed
  // when bottom numbers button is pressed,
  // 1. Call function to switch to numKeyboard
  // 2. Swap bottom numbers button to ABC (letters button)
  
  // TODO: Shift button pressed
  func shiftButtonPressed() {
    // When shift button is pressed,
    // 0. Store shift button up/down state in a controller property?
    // 1. change visual state on shift button
    // 2. when key is pressed, insert UPCASE version instead
    // 3. reset visual state on shift button
  }
  
  
  // TODO: Have a place for autocomplete bar
  // TODO: Everytime text changes, call Yelp API to
  // to see if it matches a venue nearby
  // Display the result in the autocomplete bar
  
  override func textWillChange(textInput: UITextInput) {
    // The app is about to change the document's contents. Perform any preparation here.
  }
  
  override func textDidChange(textInput: UITextInput) {
    // The app has just changed the document's contents, the document context has been updated.
    
    var textColor: UIColor
    var proxy = self.textDocumentProxy as UITextDocumentProxy
    if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
      textColor = UIColor.whiteColor()
    } else {
      textColor = UIColor.blackColor()
    }
  }

  // VIEW CONSTRAINTS

  func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView) {
    for (index, button) in enumerate(buttons) {
      // Set buttons 1px from the top, relative to their parent view
      var topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1)
      var bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1)
      var rightConstraint : NSLayoutConstraint!
      
      if index == buttons.count - 1 {
        rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1)
      } else {
        let nextButton = buttons[index+1]
        rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left, multiplier: 1.0, constant: -1)
      }
      
      var leftConstraint : NSLayoutConstraint!
      
      if index == 0 {
        leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1)
      } else {
        let prevButton = buttons[index-1]
        leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevButton, attribute: .Right, multiplier: 1.0, constant: 1)

          
        let firstButton = buttons[0]
        var widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
        
        widthConstraint.priority = 800
        mainView.addConstraint(widthConstraint)
      }
        mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
    }
  }

  func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
    for (index, rowView) in enumerate(rowViews) {
      var rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .Right, relatedBy: .Equal, toItem: inputView, attribute: .Right, multiplier: 1.0, constant: -1)
      var leftConstraint = NSLayoutConstraint(item: rowView, attribute: .Left, relatedBy: .Equal, toItem: inputView, attribute: .Left, multiplier: 1.0, constant: 1)
      
      inputView.addConstraints([leftConstraint, rightSideConstraint])
      
      var topConstraint: NSLayoutConstraint
      
      if index == 0 {
        topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: inputView, attribute: .Top, multiplier: 1.0, constant: 0)
      } else {
        let prevRow = rowViews[index-1]
        topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: prevRow, attribute: .Bottom, multiplier: 1.0, constant: 0)
        
        let firstRow = rowViews[0]
        var heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .Height, relatedBy: .Equal, toItem: rowView, attribute: .Height, multiplier: 1.0, constant: 0)
        heightConstraint.priority = 800
        inputView.addConstraint(heightConstraint)
      }
      inputView.addConstraint(topConstraint)
      
      var bottomConstraint: NSLayoutConstraint
      
      if index == rowViews.count - 1 {
        bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: inputView, attribute: .Bottom, multiplier: 1.0, constant: 0)
      } else {
        let nextRow = rowViews[index+1]
        bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: nextRow, attribute: .Top, multiplier: 1.0, constant: 0)
      }
      
      inputView.addConstraint(bottomConstraint)
    }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated
  }
}
