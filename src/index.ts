import { registerPlugin } from '@capacitor/core';

import type { PullToRefreshPlugin } from './definitions';

const PullToRefresh = registerPlugin<PullToRefreshPlugin>('PullToRefresh', {
  web: () => import('./web').then(m => new m.PullToRefreshWeb()),
});

export * from './definitions';
export { PullToRefresh };
