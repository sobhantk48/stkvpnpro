import 'cloudflare_endpoint.dart';
import 'warp_model.dart';

class WarpEngine {

  static WarpModel
      create() {

    return const WarpModel(

      endpoint:

          CloudflareEndpoint
              .endpoint,

      publicKey:

          "warp-public-key",
    );
  }
}
