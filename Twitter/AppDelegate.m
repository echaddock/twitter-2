//
//  AppDelegate.m
//  Twitter
//
//  Created by Liz Chaddock on 9/18/15.
//  Copyright © 2015 Liz Chaddock. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "SWRevealViewController.h"
#import "MenuViewController.h"
#import "ProfileViewController.h"

@interface AppDelegate () <MenuViewControllerDelegate, TweetsViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Welcome %@", user.name);
        SWRevealViewController *swvc;
        TweetsViewController *tvc = [[TweetsViewController alloc] init];
        tvc.user = user;
        tvc.revealViewController = swvc;
        tvc.delegate = self;
        
        MenuViewController *mvc = [[MenuViewController alloc] init];
        mvc.delegate = self;
        
        swvc = [[SWRevealViewController alloc] initWithRearViewController:mvc frontViewController:[[UINavigationController alloc] initWithRootViewController:tvc]];
        
        self.window.rootViewController = swvc;
    } else {
        NSLog(@"Not logged in");
        self.window.rootViewController = [[LoginViewController alloc] init];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)menuViewControllerDidFinishWithCategoryId:(NSInteger)categoryId {
    SWRevealViewController *swvc;
    MenuViewController *mvc = [[MenuViewController alloc] init];
    mvc.delegate = self;
    
    if(categoryId == 0) {
        TweetsViewController* tvc = [[TweetsViewController alloc] init];
        tvc.user = [User currentUser];
        tvc.revealViewController = swvc;
        swvc = [[SWRevealViewController alloc] initWithRearViewController:mvc frontViewController:[[UINavigationController alloc] initWithRootViewController:tvc]];
    } else if(categoryId == 1) {
        ProfileViewController* pvc = [[ProfileViewController alloc] init];
        pvc.user = [User currentUser];
        pvc.revealViewController = swvc;
        swvc = [[SWRevealViewController alloc] initWithRearViewController:mvc frontViewController:[[UINavigationController alloc] initWithRootViewController:pvc]];
    }
    
    self.window.rootViewController = swvc;
}

- (void)tweetsViewControllerDidFinishWithUser:(User *)user {
    SWRevealViewController *swvc;
    MenuViewController *mvc = [[MenuViewController alloc] init];
    mvc.delegate = self;
    
    ProfileViewController* pvc = [[ProfileViewController alloc] init];
    pvc.user = user;
    pvc.revealViewController = swvc;
    swvc = [[SWRevealViewController alloc] initWithRearViewController:mvc frontViewController:[[UINavigationController alloc] initWithRootViewController:pvc]];
    
    self.window.rootViewController = swvc;
}

- (void)userDidLogout {
    self.window.rootViewController = [[LoginViewController alloc] init];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [[TwitterClient sharedInstance] openURL:url];
     return YES;
}

@end
