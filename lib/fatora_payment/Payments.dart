import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class WebViewContainer extends StatefulWidget {
  final Uri url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body:  WebViewWidget(controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(widget.url)),
    );
  }
}
