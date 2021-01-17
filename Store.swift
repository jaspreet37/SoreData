//
//  Store.swift
//  Fiterit
//
//  Created by Apple on 18/08/18.
//  Copyright © 2018 Gurindercql. All rights reserved.
//

import Foundation

class Store {
    
    class var authKey: String?
    {
        set{
            Store.saveValue(newValue, .authKey)
        }get{
            return Store.getValue(.authKey) as? String
        }
    }
    
    class var socialId: String?
    {
        set{
            Store.saveValue(newValue, .socialId)
        }get{
            return Store.getValue(.socialId) as? String
        }
    }
    
    class var switchState : Bool?
    {
        set{
            Store.saveValue(newValue, .switchState)
        }get{
            return Store.getValue(.switchState) as? Bool
        }
    }
    
    class var deviceToken: String?
    {
        set{
            Store.saveValue(newValue, .deviceToken)
        }get{
            return Store.getValue(.deviceToken) as? String
        }
    }
    
    class var latitude: String?
    {
        set{
            Store.saveValue(newValue, .latitude)
        }get{
            return Store.getValue(.latitude) as? String
        }
    }
    
    class var longitude: String?
    {
        set{
            Store.saveValue(newValue, .longitude)
        }get{
            return Store.getValue(.longitude) as? String
        }
    }
    
    class var location: String?
    {
        set{
            Store.saveValue(newValue, .location)
        }get{
            return Store.getValue(.location) as? String
        }
    }
    
    class var userDetails: SignUpBody?
    {
        set{
            Store.saveUserDetails(newValue, .userDetails)
        }get{
            return Store.getUserDetails(.userDetails)
        }
    }
    
//    
//    static var remove: DefaultKeys!{
//        didSet{
//            Store.removeKey(remove)
//        }
//    }
    
    //MARK:-  Private Functions
    
    private class func removeKey(_ key: DefaultKeys){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        if key == .userDetails{
            UserDefaults.standard.removeObject(forKey: DefaultKeys.authKey.rawValue)
        }
        UserDefaults.standard.synchronize()
    }
    
    private class func saveValue(_ value: Any? ,_ key:DefaultKeys){
        var data: Data?
        if let value = value{
            data = NSKeyedArchiver.archivedData(withRootObject: value)
        }
        UserDefaults.standard.set(data, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private class func saveUserDetails<T: Codable>(_ value: T?, _ key: DefaultKeys){
        var data: Data?
        if let value = value{
            data = try? PropertyListEncoder().encode(value)
        }
        Store.saveValue(data, key)
    }
    
    private class func getUserDetails<T: Codable>(_ key: DefaultKeys) -> T?{
        if let data = self.getValue(key) as? Data{
            let loginModel = try? PropertyListDecoder().decode(T.self, from: data)
            return loginModel
        }
        return nil
    }
    
    private class func getValue(_ key: DefaultKeys) -> Any{
        if let data = UserDefaults.standard.value(forKey: key.rawValue) as? Data{
            if let value = NSKeyedUnarchiver.unarchiveObject(with: data){
                return value
            }else{
                return ""
            }
        }else{
            return ""
        }
    }
}
