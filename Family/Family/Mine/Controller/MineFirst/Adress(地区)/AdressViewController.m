#import "AdressViewController.h"
#import "TLCityPickerController.h"
#import "MineFirst.h"
@interface AdressViewController () <TLCityPickerDelegate>



@end

@implementation AdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self click];
}

- (void)click
{
    
    TLCityPickerController *cityPickerVC = [[TLCityPickerController alloc] init];
    
    [cityPickerVC setDelegate:self];
    
    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - TLCityPickerDelegate
- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController didSelectCity:(TLCity *)city
{
//    [self.cityPickerButton setTitle:city.cityName forState:UIControlStateNormal];
    [cityPickerViewController dismissViewControllerAnimated:YES completion:^{
            }];
    

}

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end