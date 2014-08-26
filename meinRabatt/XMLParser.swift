//
//  XMLParser.swift
//  meinRabatt
//
//  Created by Oliver Rosner on 24.08.14.
//  Copyright (c) 2014 Schilum23. All rights reserved.
//

import UIKit

protocol XMLParserDelegate {
    
    func XMLparserError(parser: XMLParser, error: String)
    
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    let url: NSURL
    var delegate: XMLParserDelegate?
    
    var objects = [Dictionary<String, String>]()
    var object = Dictionary<String, String>()
    
    var handler: (() -> Void)?
    
    var inItem = false
    var current = String()
    
    init(url: NSURL) {
        
        self.url = url
        
    }
    
    func deleteObjects() {
        
        objects.removeAll(keepCapacity: false)
        object.removeAll(keepCapacity: false)
        inItem = false
        handler = nil
        
        
    }
    
    func parse(handler: () -> Void) {
        
        self.handler = handler
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            let xmlCode = NSData(contentsOfURL: self.url)
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            
            let parser = NSXMLParser(data: xmlCode)
            parser.delegate = self
            if !parser.parse() {
                
                self.delegate?.XMLparserError(self, error: "parsen fehlgeschlagen")
                
            }
            
        }
        
    }
    
    func parser(parser: NSXMLParser!, parseErrorOccurred parseError: NSError!) {
        
        self.delegate?.XMLparserError(self, error: "parsen fehlgeschlagen")
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        if elementName == "tblShop" {

            object.removeAll(keepCapacity: false)
            inItem = true
            
        }
        current = elementName
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {

        if !inItem {
            
            return
        }
        
        if let temp = object[current] {
            
            var tempString = temp
            tempString += string
            object[current] = tempString
        } else {
            
            object[current] = string
            
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {

        if elementName == "tblShop" {
            inItem = false
            objects.append(object)
            
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            if (self.handler != nil) {
                self.handler!()
            }
            
        }
        
    }
    
}
