import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPaymentScreen extends StatefulWidget {
  final String url;

  const WebViewPaymentScreen({
    super.key,
    required this.url,
  });

  static const routeName = "WebViewPaymentScreen";

  @override
  State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState();
}

class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
  final GlobalKey webViewKey = GlobalKey();
  late Uri myUrl;
  late final WebViewController _controller;

  double progress = 0;
  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    super.initState();
    myUrl = Uri.parse(widget.url);

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) =>
              setState(() => this.progress = progress / 100),
          onPageStarted: (String url) =>
              debugPrint('Page started loading: $url'),
          onPageFinished: (String url) =>
              debugPrint('Page finished loading: $url'),
          onNavigationRequest: (NavigationRequest request) async {
            final NavigationDecision policy =
                await _pageRedirect(context, request.url);
            return policy;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(myUrl);

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            progress < 1.0
                ? Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: LinearProgressIndicator(value: progress))
                : Container(),
          ],
        ),
      ),
    );
  }

  Future<NavigationDecision> _pageRedirect(
      BuildContext context, String url) async {
    bool isSuccess = url.contains('accepted-form');
    bool isFailed = url.contains('cancelled-form');
    if (isSuccess) {
      Navigator.pop(
        context,
      );
      Fluttertoast.showToast(
          msg: "Payment Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // CommonMethods.showToast(message: 'Payment Successful');
      return NavigationDecision.prevent;
    } else if (isFailed) {
      Navigator.pop(
        context,
      );
      Fluttertoast.showToast(
          msg: "Payment Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // CommonMethods.showError(message: 'Payment Failed');
      return NavigationDecision.prevent;
    } else {
      return NavigationDecision.navigate;
    }
  }
}
