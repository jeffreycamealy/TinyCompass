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
const float pencilArmTipRadius = 3.0;
const float pencilTipRadius = 0.5;
const float pencilAngle = degToRad(65.0);

// Derived Mesurments
const float armLength = totalCompassRadius/2.0;



@implementation TinyCompass

- (void)buildSubObjects {
    // Blank
    OSCylinder *armCenter = [[OSCylinder alloc] initWithRadius:armCenterRadius height:armThickness];
    
    OSCylinder *armTip = [[OSCylinder alloc] initWithRadius:pencilArmTipRadius height:armThickness];
    OSTransformation *tipTranslation = translate(armLength, 0, 0);
    [armTip.transformations addObject:tipTranslation];
    
    OSCompositeObject *armBlank = [[OSCompositeObject alloc] initWithSubObjects:@[armCenter, armTip]];
    armBlank.compositeType = OSCTHull;
    
    // Holes
    float pencilAngleTravel = sinf(M_PI_2-pencilAngle)*(armThickness/sinf(pencilAngle));
    
    OSTaperedCylinder *pencilHole = [[OSTaperedCylinder alloc] initWithHeight:armThickness+os_epsilon
                                                                   baseRadius:pencilTipRadius
                                                                    topRadius:pencilAngleTravel+pencilTipRadius];
    [pencilHole.transformations addObject:tipTranslation];
    
    OSCompositeObject *armWithHoles = [[OSCompositeObject alloc] initWithSubObjects:@[armBlank, pencilHole]];
    armWithHoles.compositeType = OSCTDifference;
    
    [self.subObjects addObject:armWithHoles];
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

































