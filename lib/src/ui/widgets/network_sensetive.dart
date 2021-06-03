import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vootech_realchat/src/enums/connectivity_status.dart';
import 'package:vootech_realchat/src/ui/widgets/connection_lost_widget.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final VoidCallback callback;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.callback,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      return Center(
        child: ConnectionLostWidget(),
      );
    }
    return child;
  }
}
