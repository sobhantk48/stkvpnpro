class MuxConfig {

  bool enabled;

  int concurrency;

  MuxConfig({
    this.enabled = true,
    this.concurrency = 8,
  });
}
