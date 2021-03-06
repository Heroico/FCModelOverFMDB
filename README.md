FCModelOverFMDB
===============

Quick and dirty test for having a simple model based on FCModel, runing over an encrypted FMDB sqlite database.

Objective
=========

The motivation was to get a basic Model with two entities, and a One-To-Many relationship between them, working over an encrypted sqlite3 database.

The entities are  "Collection" and "Member" (which are deemed contained in the collection) 


Setup
=====

Done via CocoaPods. Assuming you have that tool installed, do:

```bash
# cd path/to/project 
$ pod install
```

Code Description
================

### 1) Dependencies

#### a) FMDB/SQLCipher

FMDB is an Objective-C sqlite3 abstraction. It has a Pod that uses SQLCipher as sqlite3 context, which this project uses:

```
#used because latest FCmodel Release depends on it
pod 'FMDB/SQLCipher', '2.1'
```

#### b) FCModel

FCModel is a library that implements ActiveRecord over FMDB (thus sqlite).

Code was manually included, from tag v0.2.0, because some modifications were needed before getting FCModel to work on the FMDB/SQLCipher code.

### 2) Sample App

There is a sample app that displays a list of Collection entities, that supports creation and deletion.

Tapping on a Collection will push a new list with its child Members, supporting member creation and deletion.

Conclusions and Remarks
=======================

The current state of this project complies with the objectives.

FCModel is a young project, it is changing fast, but seems to be just starting.

FCModel raises exceptions when it encounters an unexpected state, which has to be dealt with appropriately.

### Additional Remarks: March 21, 2014:

FCModel offers nothing in the way of having the operations run outside the main queue. An additional layer has to be added on top of it.

FCModel doesn't include any object graph (relationships) management. It has to be implemented explicitly in each model.

Branching the FCModel to use FMDB/SQLCipher is not hard, but the details are likely to change in the near future as new library versions get released.
