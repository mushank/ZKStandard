# ZKStandard
A basic framework for iOS App written in Objective-C

## 1. Install

**Install manually, download the source folder `ZKStandard` and drag it into your project.**

⚠️***Attention:*** *I noticed that in most cases you will tend to add your own code to this framework, so I have removed the cocoapods installation way. Please install manually instead*

## 2. Usage

Set your project `Prefix Header` value as `$(SRCROOT)/ZKStandard/Config/ZKPrefix.pch` and then begin your coding.

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

