//
//  CGMessageTextView.swift
//
//  Copyright (c) 2017 Carmelo Gallo (https://carmelogallo.com - https://github.com/cikpis)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

public protocol CGMessageTextViewDelegate: class {
    func contentSizeDidChange(withContentSize contentSize: CGSize)
    func contentSizeWidthDidChange(withWidth width: CGFloat)
    func contentSizeDeltaWidthDidChange(withDelta delta: CGFloat)
    func contentSizeHeightDidChange(withHeight height: CGFloat)
    func contentSizeDeltaHeightDidChange(withDelta delta: CGFloat)
}

extension CGMessageTextViewDelegate {
    func contentSizeDidChange(withContentSize contentSize: CGSize) { }
    func contentSizeWidthDidChange(withWidth width: CGFloat) { }
    func contentSizeDeltaWidthDidChange(withDelta delta: CGFloat) { }
    func contentSizeHeightDidChange(withHeight height: CGFloat) { }
    func contentSizeDeltaHeightDidChange(withDelta delta: CGFloat) { }
}

public class CGMessageTextView: UITextView {
    
    // MARK: - Private UI Properties
    private let placeholderLabel = UILabel()
    
    // MARK: - Private Logic Properties
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    // MARK: - Override Properties
    override public var text: String! {
        didSet { textDidChange() }
    }
    override public var attributedText: NSAttributedString! {
        didSet { textDidChange() }
    }
    override public var contentSize: CGSize {
        didSet {
            guard oldValue != contentSize else { return }
            let deltaWidth = contentSize.width - oldValue.width
            let deltaHeight = contentSize.height - oldValue.height
            messageTextViewDelegate?.contentSizeDidChange(withContentSize: contentSize)
            messageTextViewDelegate?.contentSizeWidthDidChange(withWidth: contentSize.width)
            messageTextViewDelegate?.contentSizeDeltaWidthDidChange(withDelta: deltaWidth)
            messageTextViewDelegate?.contentSizeHeightDidChange(withHeight: contentSize.height)
            messageTextViewDelegate?.contentSizeDeltaHeightDidChange(withDelta: deltaHeight)
        }
    }
    override public var textContainerInset: UIEdgeInsets {
        didSet { setupConstraints() }
    }
    
    // MARK: - Public Properties
    public weak var messageTextViewDelegate: CGMessageTextViewDelegate?
    public var placeholderText: String = "Write something..." {
        didSet {
            placeholderLabel.text = placeholderText
        }
    }
    public var placeholderTextColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderTextColor
        }
    }
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 17.0) {
        didSet {
            placeholderLabel.font = placeholderFont
        }
    }
    public var placeholderTextAlignment: NSTextAlignment = .left {
        didSet {
            placeholderLabel.textAlignment = placeholderTextAlignment
        }
    }
    
    // MARK: - Life Cycle Methods
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        startSetups()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startSetups()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name.UITextViewTextDidChange,
                                                  object: nil)
    }
    
    // MARK: - Setup Methods
    private func startSetups() {
        setupComponents()
        setupConstraints()
        setupObservers()
    }
    
    private func setupComponents() {
        // placeholderLabel
        placeholderLabel.numberOfLines = 0
        placeholderLabel.text = placeholderText
        placeholderLabel.textColor = placeholderTextColor
        placeholderLabel.font = placeholderFont
        placeholderLabel.textAlignment = placeholderTextAlignment
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeholderLabel)
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["placeholderLabel": placeholderLabel]
        let metrics: [String: Any] = [
            "marginTop": textContainerInset.top,
            "marginLeft": textContainerInset.left + textContainer.lineFragmentPadding,
            "marginBottom": textContainerInset.bottom,
            "marginRight": textContainerInset.right
        ]
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-marginLeft-[placeholderLabel]-marginRight-|",
                                                            metrics: metrics,
                                                            views: views)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-marginTop-[placeholderLabel]-marginBottom-|",
                                                         metrics: metrics,
                                                         views: views)
        let deltaWidth = -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        newConstraints.append(NSLayoutConstraint(item: placeholderLabel,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .width,
                                                 multiplier: 1.0,
                                                 constant: deltaWidth
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
    }
    
    // MARK: - Private Methods
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
