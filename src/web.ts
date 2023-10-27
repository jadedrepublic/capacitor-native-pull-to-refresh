import { WebPlugin } from '@capacitor/core';

import type { PullToRefreshPlugin } from './definitions';

export class PullToRefreshWeb extends WebPlugin implements PullToRefreshPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
