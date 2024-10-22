
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class RecipeWebView extends StatefulWidget {
  final String url;

  const RecipeWebView(this.url, {super.key});

  @override
  State<RecipeWebView> createState() => RecipeWebViewState();
}

class RecipeWebViewState extends State<RecipeWebView> {
  late String finalUrl;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the final URL
    if (widget.url.toString().contains("http://")) {
      finalUrl = widget.url.toString().replaceAll("http://", "https://");
      print(finalUrl);
    } else {
      finalUrl = widget.url;
      print(widget.url);
    }

    // Ensure that the WebView is properly initialized
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(finalUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Recipe Detail"),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
