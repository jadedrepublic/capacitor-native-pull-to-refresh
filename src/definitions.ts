// definitions.ts
import { Plugin } from '@capacitor/core'
import type { PluginListenerHandle } from '@capacitor/core';

export interface PullToRefreshResponse {
  enabled: boolean;
}

export interface PullToRefreshStateResponse {
  refreshing: boolean;
}

export interface SetScrollPositionOptions {
  scroll_position: number;
  threshold?: number;
}

export interface ManuallyTriggerRefreshingStateOptions {
  offset?: number; 
}

export interface PullToRefreshPlugin extends Plugin {
  /**
   * Enables the pull-to-refresh functionality.
   * 
   * @returns A promise that resolves when the pull-to-refresh functionality is enabled.
   */
  enable(): Promise<PullToRefreshResponse>;

  /**
   * Disables the pull-to-refresh functionality.
   * 
   * @returns A promise that resolves when the pull-to-refresh functionality is disabled.
   */
  disable(): Promise<PullToRefreshResponse>;

  /**
   * Ends the refreshing state initiated by pull-to-refresh.
   * 
   * @returns A promise that resolves when the refreshing state is ended.
   */
  endRefreshing(): Promise<PullToRefreshStateResponse>;

  /**
   * 
   * Sets the scroll position of the webView.scrollView.
   * 
   * @param options Configuration options for setting the scroll position.
   * 
   * Optional to use, default behavior of UIRefreshControl() only works with the main scrollview, so a workaround is needed for additional scroll containers e.g. modals.
   * 
   */
  setScrollPosition(options: SetScrollPositionOptions): void;
  
  /**
   * Used with @setScrollPosition
   * 
   * Example Usage:
   * 
   * const threshold = 100;
   * 
   * scrollContainer.addEventListener("scroll", async function () {
   *  if (scrollContainer.scrollTop < 0) {
   *     PullToRefresh.setScrollPosition({ scroll_position: scrollContainer.scrollTop, threshold: threshold })
   *   }
   * });
   *
   * scrollContainer.addEventListener("touchend", async function () {
   *   if (scrollContainer.scrollTop <= threshold) {
   *     PullToRefresh.manuallyTriggerRefreshingState({ offset: -30 })
   *   }
   * })
   *
   * PullToRefresh.addListener("state", function ({ refreshing }) {
   *   if (refreshing) {
   *     setTimeout(() => {
   *       PullToRefresh.endRefreshing()
   *     }, 3000)
   *   }
   * })
   * 
   * @param options Configuration options when manually triggering refreshing state.
   * 
   */
  manuallyTriggerRefreshingState(options: ManuallyTriggerRefreshingStateOptions): void
  /**
   * Adds a listener for the "state" event which is triggered when the pull-to-refresh state changes.
   *
   * @param eventName The name of the event to listen for.
   * @param listenerFunc The function to be executed when the event is triggered.
   *
   * @returns PullToRefreshStateResponse.
   */
  addListener(eventName: 'state', listenerFunc: (data: PullToRefreshStateResponse) => void): Promise<PluginListenerHandle> & PluginListenerHandle;
  removeAllListeners(): Promise<void>;
}