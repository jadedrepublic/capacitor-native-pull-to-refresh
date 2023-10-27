export interface PullToRefreshPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
