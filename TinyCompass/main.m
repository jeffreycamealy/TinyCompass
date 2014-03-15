//
//  main.m
//  TinyCompass
//
//  Created by Jeffrey Camealy on 3/14/14.
//  Copyright (c) 2014 bearMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectiveSCAD.h"
#import "TinyCompass.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [ObjectiveSCAD scadObjects:@[[TinyCompass new]]];
    }
    return 0;
}

