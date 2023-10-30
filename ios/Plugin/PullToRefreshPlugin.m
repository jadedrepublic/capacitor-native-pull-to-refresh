#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and 
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(PullToRefreshPlugin, "PullToRefresh",
  CAP_PLUGIN_METHOD(enable, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(disable, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(endRefreshing, CAPPluginReturnPromise);
  CAP_PLUGIN_METHOD(setScrollPosition, CAPPluginReturnNone);
  CAP_PLUGIN_METHOD(manuallyTriggerRefreshingState, CAPPluginReturnNone);
)