platform :ios, "7.0"

pod 'CocoaLumberjack', '~> 1.6'
pod 'ZauberCommons', '0.1.0'
pod 'FMDB/SQLCipher', '2.2'

target :test, :exclusive => true do
  link_with "FMDBTestTests"
  pod 'Kiwi/XCTest', '~> 2.2.3' #RKKiwiMatchers pod doesn't work with latest kiwi pod, had to be manually included
end