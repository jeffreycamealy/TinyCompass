//
//  TinyCompass.m
//  TinyCompass
//
//  Created by Jeffrey Camealy on 3/14/14.
//  Copyright (c) 2014 bearMountain. All rights reserved.
//

#import "TinyCompass.h"
#import "ObjectiveSCADHeaders.h"

#pragma mark - Measurements

// Measurements
const float pinCapRadius = 4.5;
const float pinShaftRadius = 0.375;
const float armThickness = 3.5;
const float totalCompassRadius = 55.0;
const float armCenterRadius = 10.0;
const float screwRadius = 1.75;

// Derived Mesurments
const float armLength = totalCompassRadius/2.0;



@implementation TinyCompass

- (void)buildSubObjects {
    [self.subObjects addObject:[self pinArm]];
}

- (OSObject *)pinArm {
    // Pin Arm
    OSCylinder *pinArmCenter = [[OSCylinder alloc] initWithRadius:armCenterRadius height:armThickness];
    
    OSCylinder *pinArmTip = [[OSCylinder alloc] initWithRadius:pinCapRadius height:armThickness];
    OSTransformation *pinArmTipTranslation = translate(armLength, 0, 0);
    [pinArmTip.transformations addObject:pinArmTipTranslation];
    
    OSCompositeObject *pinArmBlank = [[OSCompositeObject alloc] initWithSubObjects:@[pinArmCenter, pinArmTip]];
    pinArmBlank.compositeType = OSCTHull;
    
    // Holes
    OSCylinder *pinHole = [[OSCylinder alloc] initWithRadius:pinShaftRadius height:armThickness+os_epsilon];
    [pinHole.transformations addObject:pinArmTipTranslation];
    
    OSCylinder *screwHole = [[OSCylinder alloc] initWithRadius:screwRadius height:armThickness+os_epsilon];
    
    OSCompositeObject *pinArmWithHoles = [[OSCompositeObject alloc] initWithSubObjects:@[pinArmBlank, pinHole, screwHole]];
    pinArmWithHoles.compositeType = OSCTDifference;
    
    return pinArmWithHoles;
}


@end

































