//
//  ColorList.swift
//  Kantstime
//
//  Created by gyoungeun ola bae on 21/01/2018.
//  Copyright © 2018 gyoungeun ola bae. All rights reserved.
//

import UIKit

extension UIColor {
    
    func colorListPM(count: Int)->UIColor
    {
        if count==0
        {
            return UIColor.init ( red: 248.0/255.0, green: 252.0/255.0, blue: 253.0/255.0, alpha: 1 )
        }
        else if count==1
        {
            return UIColor.init ( red: 227.0/255.0, green: 236.0/255.0, blue: 253.0/255.0, alpha: 1 )
        }
        else if count==2
        {
            return UIColor.init ( red: 195.0/255.0, green: 210.0/255.0, blue: 228.0/255.0, alpha: 1 )
        }
        else if count==3
        {
            return UIColor.init ( red: 166.0/255.0, green: 187.0/255.0, blue: 216.0/255.0, alpha: 1 )
        }
        else if count==4
        {
            return UIColor.init ( red: 142.0/255.0, green: 149.0/255.0, blue: 195.0/255.0, alpha: 1 )
        }
        else if count==5
        {
            return UIColor.init ( red: 130.0/255.0, green: 106.0/255.0, blue: 174.0/255.0, alpha: 1 )
            
        }
        else if count==6
        {
            return UIColor.init ( red: 120.0/255.0, green: 67.0/255.0, blue: 153.0/255.0, alpha: 1 )
        }
        else if count==7
        {
            return UIColor.init ( red: 94.0/255.0, green: 44.0/255.0, blue: 133.0/255.0, alpha: 1 )
        }
        else if count==8
        {
            return UIColor.init ( red: 110.0/255.0, green: 21.0/255.0, blue: 121.0/255.0, alpha: 1 )
        }
        else if count == 9
        {
            return UIColor.init ( red: 67.0/255.0, green: 1.0/255.0, blue: 75.0/255.0, alpha: 1 )
        }
        
        return UIColor.darkGray
    }
    func colorListAM(count: Int)->UIColor
    {
        if count==0
        {
            return UIColor.init(red: 88.0/255.0, green: 156.0/255.0, blue: 166.0/255.0, alpha: 1)
        }
        else if count==1
        {
            return UIColor.init ( red: 105.0/255.0, green: 156.0/255.0, blue: 139.0/255.0, alpha: 1 )
        }
        else if count==2
        {
            return UIColor.init ( red: 123.0/255.0, green: 171.0/255.0, blue: 142.0/255.0, alpha: 1 )
        }
        else if count==3
        {
            return UIColor.init ( red: 139.0/255.0, green: 180.0/255.0, blue: 141.0/255.0, alpha: 1 )
        }
        else if count==4
        {
            return UIColor.init ( red: 159.0/255.0, green: 187.0/255.0, blue: 132.0/255.0, alpha: 1 )
        }
        else if count==5
        {
            return UIColor.init ( red: 176.0/255.0, green: 188.0/255.0, blue: 120.0/255.0, alpha: 1 )
            
        }
        else if count==6
        {
            return UIColor.init ( red: 198.0/255.0, green: 174.0/255.0, blue: 76.0/255.0, alpha: 1 )
        }
        else if count==7
        {
            return UIColor.init(red: 207.0/255.0, green: 169.0/255.0, blue: 66.0/255.0, alpha: 1)
        }
        else if count==8
        {
            return UIColor.init ( red: 211.0/255.0, green: 142.0/255.0, blue: 50.0/255.0, alpha: 1 )
        }
        else if count == 9
        {
            return UIColor.init ( red: 201.0/255.0, green: 88.0/255.0, blue: 46.0/255.0, alpha: 1 )
        }
        
        return UIColor.darkGray
    }
}

