# capacitor-native-pull-to-refresh

Native pull to refresh plugin for capacitor

## Install

```bash
npm install capacitor-native-pull-to-refresh
npx cap sync
import { PullToRefresh } from "capacitor-native-pull-to-refresh";

This plugin Is a WIP, only iOS supported atm.
```

## API

<docgen-index>

* [`enable()`](#enable)
* [`disable()`](#disable)
* [`endRefreshing()`](#endrefreshing)
* [`setScrollPosition(...)`](#setscrollposition)
* [`manuallyTriggerRefreshingState(...)`](#manuallytriggerrefreshingstate)
* [`addListener('state', ...)`](#addlistenerstate)
* [`removeAllListeners()`](#removealllisteners)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### enable()

```typescript
enable() => Promise<PullToRefreshResponse>
```

Enables the pull-to-refresh functionality.

**Returns:** <code>Promise&lt;<a href="#pulltorefreshresponse">PullToRefreshResponse</a>&gt;</code>

--------------------


### disable()

```typescript
disable() => Promise<PullToRefreshResponse>
```

Disables the pull-to-refresh functionality.

**Returns:** <code>Promise&lt;<a href="#pulltorefreshresponse">PullToRefreshResponse</a>&gt;</code>

--------------------


### endRefreshing()

```typescript
endRefreshing() => Promise<PullToRefreshStateResponse>
```

Ends the refreshing state initiated by pull-to-refresh.

**Returns:** <code>Promise&lt;<a href="#pulltorefreshstateresponse">PullToRefreshStateResponse</a>&gt;</code>

--------------------


### setScrollPosition(...)

```typescript
setScrollPosition(options: SetScrollPositionOptions) => void
```

Sets the scroll position of the webView.scrollView.

| Param         | Type                                                                          | Description                                                                                                                                                                                                                 |
| ------------- | ----------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`options`** | <code><a href="#setscrollpositionoptions">SetScrollPositionOptions</a></code> | Configuration options for setting the scroll position. Optional to use, default behavior of UIRefreshControl() only works with the main scrollview, so a workaround is needed for additional scroll containers e.g. modals. |

--------------------


### manuallyTriggerRefreshingState(...)

```typescript
manuallyTriggerRefreshingState(options: ManuallyTriggerRefreshingStateOptions) => void
```

Used with @setScrollPosition

Example Usage:

const threshold = 100;

scrollContainer.addEventListener("scroll", async function () {
 if (scrollContainer.scrollTop &lt; 0) {
    PullToRefresh.setScrollPosition({ scroll_position: scrollContainer.scrollTop, threshold: threshold })
  }
});

scrollContainer.addEventListener("touchend", async function () {
  if (scrollContainer.scrollTop &lt;= threshold) {
    PullToRefresh.manuallyTriggerRefreshingState({ offset: -30 })
  }
})

PullToRefresh.addListener("state", function ({ refreshing }) {
  if (refreshing) {
    setTimeout(() =&gt; {
      PullToRefresh.endRefreshing()
    }, 3000)
  }
})

| Param         | Type                                                                                                    | Description                                                      |
| ------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| **`options`** | <code><a href="#manuallytriggerrefreshingstateoptions">ManuallyTriggerRefreshingStateOptions</a></code> | Configuration options when manually triggering refreshing state. |

--------------------


### addListener('state', ...)

```typescript
addListener(eventName: 'state', listenerFunc: (data: PullToRefreshStateResponse) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Adds a listener for the "state" event which is triggered when the pull-to-refresh state changes.

| Param              | Type                                                                                                 | Description                                              |
| ------------------ | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| **`eventName`**    | <code>'state'</code>                                                                                 | The name of the event to listen for.                     |
| **`listenerFunc`** | <code>(data: <a href="#pulltorefreshstateresponse">PullToRefreshStateResponse</a>) =&gt; void</code> | The function to be executed when the event is triggered. |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

--------------------


### removeAllListeners()

```typescript
removeAllListeners() => Promise<void>
```

--------------------


### Interfaces


#### PullToRefreshResponse

| Prop          | Type                 |
| ------------- | -------------------- |
| **`enabled`** | <code>boolean</code> |


#### PullToRefreshStateResponse

| Prop             | Type                 |
| ---------------- | -------------------- |
| **`refreshing`** | <code>boolean</code> |


#### SetScrollPositionOptions

| Prop                  | Type                |
| --------------------- | ------------------- |
| **`scroll_position`** | <code>number</code> |
| **`threshold`**       | <code>number</code> |


#### ManuallyTriggerRefreshingStateOptions

| Prop         | Type                |
| ------------ | ------------------- |
| **`offset`** | <code>number</code> |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |

</docgen-api>
