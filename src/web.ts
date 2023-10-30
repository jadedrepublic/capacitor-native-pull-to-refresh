import { WebPlugin } from '@capacitor/core';
import type { PullToRefreshPlugin, PullToRefreshResponse, PullToRefreshStateResponse } from './definitions';

export class PullToRefreshWeb extends WebPlugin implements PullToRefreshPlugin {
  async enable(): Promise<PullToRefreshResponse> {
    return {
      enabled: false
    };
  }
  async disable(): Promise<PullToRefreshResponse> {
    return {
      enabled: false
    };
  }
  async endRefreshing(): Promise<PullToRefreshStateResponse> {
    return {
      refreshing: false
    };
  }
  setScrollPosition(): void {

  }
  manuallyTriggerRefreshingState(): void {

  }
}