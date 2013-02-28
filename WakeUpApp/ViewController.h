#import <UIKit/UIKit.h>

#import "BluetoothManager.h"
#import "BluetoothDevice.h"

@interface ViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
//    BluetoothManager *bluetoothManager;
    NSMutableArray *items;
    
    IBOutlet UITableView *itemTableView;
    IBOutlet UITextField *msg;
    IBOutlet UIActivityIndicatorView *indicator;
}

@property BluetoothManager *bluetoothManager;

-(void)initValues;
-(void)viewAppear;
-(void)viewDisappear;

@end

@interface ItemRow : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *description;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) BluetoothDevice *bluetoothDevice;

-(id)initWithName:(NSString *)aName
      description:(NSString *)aDescription
             type:(NSInteger )aType
  bluetoothDevice:(BluetoothDevice *)aBluetoothDevice;

@end
