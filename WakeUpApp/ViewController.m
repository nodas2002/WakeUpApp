#import "ViewController.h"

@implementation ViewController

@synthesize bluetoothManager;

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self scanButton];
}

-(void)viewDisappear
{
//    [self doBluetoothOFF];
}

-(void)viewAppear
{
//    [self scanButton];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    for (UIView *unview in cell.contentView.subviews)
    {
        [unview removeFromSuperview];
    }
    
    ItemRow *itemRow = (ItemRow *)[items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = itemRow.name;
    cell.detailTextLabel.text = itemRow.description;

//    cell.textLabel.text = @"d12345-bt";
//    cell.detailTextLabel.text = @"12:34:56:78:9A:BC";

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemRow *itemRow = (ItemRow *)[items objectAtIndex:indexPath.row];
    
    NSString *message = [NSString stringWithFormat:@"Connect %@ [%@]", itemRow.name, itemRow.description];
    msg.text = message;
    
    [self deviceConnect: indexPath.row];
    [itemTableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self initValues];
}

-(void)initValues
{
	items = [[NSMutableArray alloc] init];
    bluetoothManager = [BluetoothManager sharedInstance];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(deviceDiscovered:)
     name:@"BluetoothDeviceDiscoveredNotification"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(bluetoothAvailabilityChanged:)
     name:@"BluetoothAvailabilityChangedNotification"
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(applicationDidEndResumeAnimation:)
     name:@"UIApplicationDidEndResumeAnimationNotification"
     object:nil];
    
    CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(),
                                    NULL,
                                    dataCallBack,
                                    NULL,
                                    NULL,
                                    CFNotificationSuspensionBehaviorDeliverImmediately);
}

void dataCallBack (CFNotificationCenterRef center,
                   void *observer,
                   CFStringRef name,
                   const void *object,
                   CFDictionaryRef userInfo)
{
//    NSLog(@"%@",(__bridge NSString *)name);
    NSString *str = (__bridge NSString *)name;
    NSLog(@"%@",str);
}

-(void) clearAllList
{
    items = nil;
    [itemTableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)scanButton
{
    bluetoothManager = [BluetoothManager sharedInstance];
    [self doBluetoothOFF];
    [NSThread sleepForTimeInterval:1];
    [self doBluetoothON];
    [NSThread sleepForTimeInterval:1];
    [self doScan2];
}

-(void)doScan2
{
    [bluetoothManager resetDeviceScanning];

    [indicator startAnimating];
    msg.text = @"機器を検索中...";

    if ([bluetoothManager enabled] == NO)
    {
        [bluetoothManager setPowered:YES];
        [bluetoothManager setEnabled:YES];
    }
    [self clearAllList];
//    [bluetoothManager setDeviceScanningEnabled:NO];
    [bluetoothManager setDeviceScanningEnabled:YES];
}

- (IBAction)doBluetoothON
{
    msg.text = @"Bluetooth ONにしました。";
    [bluetoothManager setPowered:YES];
    [bluetoothManager setEnabled:YES];
}

- (IBAction)doBluetoothOFF
{
    msg.text = @"Bluetooth OFFにしました。";
    [bluetoothManager setDeviceScanningEnabled:NO];
    [self clearAllList];
    [indicator stopAnimating];
    [bluetoothManager setEnabled:NO];
    [bluetoothManager setPowered:NO];
}

- (void)bluetoothAvailabilityChanged:(NSNotification *)notification
{
}

- (void)applicationDidEndResumeAnimation:(NSNotification *)notification
{
    [self scanButton];
}

- (void)deviceDiscovered:(NSNotification *) notification
{
    BluetoothDevice *bt = [notification object];
    
    ItemRow *itemRow = [[ItemRow alloc]
                        initWithName:bt.name
                        description:bt.address
                        type:0
                        bluetoothDevice:bt];
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:items];
    [tempArray addObject:itemRow];
    items = tempArray;
    [itemTableView reloadData];
}

- (void)deviceConnect:(NSInteger)index
{
    ItemRow *itemRow = (ItemRow *)[items objectAtIndex:index];
    [itemRow.bluetoothDevice connect];
}

@end

@implementation ItemRow
@synthesize name, description, type, bluetoothDevice;

-(id)initWithName:(NSString *)aName
      description:(NSString *)aDescription
             type:(NSInteger )aType
  bluetoothDevice:(BluetoothDevice *)aBluetoothDevice
{
	self.name = aName;
	self.description = aDescription;
	self.type = aType;
    self.bluetoothDevice = aBluetoothDevice;
	return self;
}

@end
