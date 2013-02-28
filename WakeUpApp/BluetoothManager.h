/*
 *     Generated by class-dump 3.3.4 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2011 by Steve Nygard.
 */

#import "CDStructures.h"
#import "Foundation/NSObject.h"

@class NSMutableDictionary;

@interface BluetoothManager : NSObject
{
    struct BTLocalDeviceImpl *_localDevice;
    struct BTSessionImpl *_session;
    int _available;
    BOOL _audioConnected;
    BOOL _scanningEnabled;
    BOOL _scanningInProgress;
    unsigned int _scanningServiceMask;
    struct BTDiscoveryAgentImpl *_discoveryAgent;
    struct BTPairingAgentImpl *_pairingAgent;
    struct BTAccessoryManagerImpl *_accessoryManager;
    NSMutableDictionary *_btAddrDict;
    NSMutableDictionary *_btDeviceDict;
    NSMutableDictionary *_seekingInProgressDict;
}

+ (id)sharedInstance;
+ (int)lastInitError;
- (BOOL)available;
- (id)init;
- (BOOL)_attach:(id)arg1;
- (BOOL)_setup:(struct BTSessionImpl *)arg1;
- (void)_cleanup:(BOOL)arg1;
- (void)dealloc;
- (void)_postNotificationWithArray:(id)arg1;
- (void)_postNotification:(id)arg1;
- (void)postNotification:(id)arg1;
- (void)postNotificationName:(id)arg1 object:(id)arg2;
- (void)postNotificationName:(id)arg1 object:(id)arg2 error:(id)arg3;
- (int)powerState;
- (BOOL)powered;
- (BOOL)enabled;
- (BOOL)setPowered:(BOOL)arg1;
- (BOOL)setEnabled:(BOOL)arg1;
- (void)_powerChanged;
- (BOOL)isAnyoneScanning;
- (id)addDeviceIfNeeded:(struct BTDeviceImpl *)arg1;
- (void)_removeDevice:(id)arg1;
- (BOOL)wasDeviceDiscovered:(id)arg1;
- (BOOL)deviceScanningEnabled;
- (BOOL)deviceScanningInProgress;
- (void)resetDeviceScanning;
- (void)_scanForServices:(unsigned int)arg1 withMode:(int)arg2;
- (void)scanForServices:(unsigned int)arg1;
- (void)scanForConnectableDevices:(unsigned int)arg1;
- (void)setDeviceScanningEnabled:(BOOL)arg1;
- (void)_restartScan;
- (void)_setScanState:(int)arg1;
- (void)_discoveryStateChanged;
- (BOOL)isDiscoverable;
- (void)setDiscoverable:(BOOL)arg1;
- (BOOL)devicePairingEnabled;
- (void)setDevicePairingEnabled:(BOOL)arg1;
- (void)cancelPairing;
- (void)unpairDevice:(id)arg1;
- (id)pairedDevices:(BOOL)arg1;
- (id)pairedDevices;
- (id)pairedLEDevices;
- (void)setPincode:(id)arg1 forDevice:(id)arg2;
- (void)acceptSSP:(int)arg1 forDevice:(id)arg2;
- (void)connectDevice:(id)arg1 withServices:(unsigned int)arg2;
- (void)connectDevice:(id)arg1;
- (BOOL)connectable;
- (void)setConnectable:(BOOL)arg1;
- (id)connectingDevices;
- (id)connectedDevices;
- (BOOL)_onlySensorsConnected;
- (BOOL)connected;
- (void)_connectedStatusChanged;
- (void)_connectabilityChanged;
- (BOOL)audioConnected;
- (void)setAudioConnected:(BOOL)arg1;
- (void)startVoiceCommand:(id)arg1;
- (void)endVoiceCommand:(id)arg1;
- (void)_sendSeekStart:(id)arg1 forDevice:(id)arg2;
- (void)_stopSeeking:(id)arg1 forDevice:(id)arg2;
- (void)sendContact:(id)arg1 toDevice:(id)arg2;
- (void)sendAllContactsToDevice:(id)arg1;
- (BOOL)isServiceSupported:(unsigned int)arg1;
- (void)enableTestMode;

@end
