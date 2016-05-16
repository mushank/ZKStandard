# ZKStandard
A basic framework for iOS App written in Objective-C

## 1. Install

```
pod 'ZKStandard', '~> 1.0'
```

## 2. Usage

Before using, you need to set your project `Prefix Header` value as `$(SRCROOT)/ZKStandard/Config/ZKPrefix.pch`

> TARGETS -> Build Settings -> Apple LLVM 7.1 - Language -> Prefix Header

## 3. Source files

- ZKStandard.h

#### BaseObject

- ZKBaseModel
- ZKBaseEntity
- ZKTableView
- ZKViewController
- ZKNavigationController
- ZKNavigationController
- ZKTableViewController

#### Category

- NSArray+ZKExtension
- NSDate+ZKExtension
- NSDictionary+ZKExtension
- NSString+ZKExtension
- UIViewController+ZKExtension
- MBProgressHUD+ZKExtension

#### Network

- ZKAPIConstants
- ZKResponseEntity
- ZKRequestManager
- ZKNetworkUtils

#### Utilities

- ZKUtils
- ZKFileManager

#### Config

- ZKConfig.plist
- ZKMacros.h
- ZKPrefix.pch

