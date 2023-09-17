import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:leatherback_sdk/core/cores.dart';
import 'package:leatherback_sdk/ui/widgets/app_rectangle.dart';
import 'package:leatherback_sdk/ui/widgets/base_dialog_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CardAuthScreen extends StatefulWidget {
  final int amount;
  final String currency;
  final String html;

  const CardAuthScreen({
    Key? key,
    required this.amount,
    required this.currency,
    required this.html,
  }) : super(key: key);

  @override
  State<CardAuthScreen> createState() => _CardAuthScreenState();
}

class _CardAuthScreenState extends State<CardAuthScreen> {
  int progress = 0;

  late WebViewController _controller;

  final viewPortHtml =
      '<head> <meta name="viewport" content="width=device-width, initial-scale=0.75, user-scalable=1.0, minimum-scale=0.25, maximum-scale=1.0"></head> ';

  ///[INFO:CONSOLE(0)] "[Report Only] Refused to frame 'https://mtf.gateway.mastercard.com/' because an ancestor violates the following Content Security Policy directive: "frame-ancestors 'self'".
  ///[INFO:CONSOLE(1)] "Uncaught Error: Method not found", source: https://mtf.gateway.mastercard.com/callbackInterface/gateway/83334e24d6e90db856a67c874f7fc64b7bc63aeb90e1911f4cd2a82f90212a37 (1)
  ///window.opener.postMessage({\"auth\":true}, \"*\");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  String url = "";

  _initInAppWebView() async {
    // if (Platform.isAndroid) {
    //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    // }
    webViewController?.loadData(data: '''
    '$viewPortHtml ${widget.html}'
''');
    // webViewController?.loadData(data: '''      <html>
    //
    // <head>
    // <script type="text/javascript">
    //     function invokeNative() {
    //     window.flutter_inappwebview.callHandler("myHandlerName", "You are good");
    //   window.parent.postMessage(JSON.stringify({ "result":"SUCCESS" }));
    // }
    // </script> </head>
    //
    // <body>
    // <form>
    // <input type="button" value="Click me!" onclick="invokeNative()" />
    // </form> </body>
    //
    // </html>''');
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialogScreen(
      showGoBack: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: AppContainer(
            radius: 12,
            height: MediaQuery.of(context).size.height * 0.5,
            // width: double.maxFinite,
            width: MediaQuery.of(context).size.width * 0.9,
            color: Palette.white,

            ///
            // child: InAppWebView(
            //   key: webViewKey,
            //   initialUrlRequest:
            //       URLRequest(url: Uri.parse("https://inappwebview.dev/")),
            //   initialOptions: options,
            //   onWebViewCreated: (controller) {
            //     webViewController = controller;
            //     _initInAppWebView();
            //     controller.addJavaScriptHandler(
            //         handlerName: 'myHandlerName',
            //         callback: (args) {
            //           Console.log('myHandlerName', url.toString());
            //           return {'bar': 'bar_value', 'baz': 'baz_value'};
            //         });
            //   },
            //   onLoadStart: (controller, url) {
            //     Console.log('onLoadStart', url.toString());
            //   },
            //   androidOnPermissionRequest:
            //       (controller, origin, resources) async {
            //     Console.log('androidOnPermissionRequest', origin);
            //     return PermissionRequestResponse(
            //       resources: resources,
            //       action: PermissionRequestResponseAction.GRANT,
            //     );
            //   },
            //   shouldOverrideUrlLoading: (controller, navigationAction) async {
            //     var uri = navigationAction.request.url!;
            //     Console.log('shouldOverrideUrlLoading', url.toString());
            //
            //     // if (![ "http", "https", "file", "chrome",
            //     //   "data", "javascript", "about"].contains(uri.scheme)) {
            //     //   if (await canLaunch(url)) {
            //     //     // Launch the App
            //     //     await launch(
            //     //       url,
            //     //     );
            //     //     // and cancel the request
            //     //     return NavigationActionPolicy.CANCEL;
            //     //   }
            //     // }
            //
            //     return NavigationActionPolicy.ALLOW;
            //   },
            //   onLoadStop: (controller, url) async {
            //     Console.log('onLoadStop', url.toString());
            //     progress = 0;
            //     setState(() {});
            //   },
            //   onLoadError: (controller, url, code, message) {
            //     Console.log('onProgressChanged', url.toString());
            //   },
            //   onProgressChanged: (controller, p) {
            //     Console.log('onProgressChanged', url.toString());
            //     if (progress == 100) {
            //       progress = 0;
            //     }
            //     progress = p;
            //     setState(() {});
            //   },
            //   onUpdateVisitedHistory: (controller, url, androidIsReload) {
            //     Console.log('onUpdateVisitedHistory', url.toString());
            //     // this.url = url.toString();
            //   },
            //   onConsoleMessage: (controller, consoleMessage) {
            //     Console.log('onConsoleMessage', consoleMessage.message);
            //   },
            //   onLoadHttpError: (controller, uri, i, str) {
            //     Console.log('onLoadHttpError', str);
            //   },
            //   onJsAlert: (controller, alert) {
            //     Console.log('onJsAlert', alert.message);
            //     return Future.value(null);
            //   },
            //   onJsPrompt: (controller, alert) {
            //     Console.log('onJsPrompt', alert.message);
            //     return Future.value(null);
            //   },
            //   onLoadResource: (controller, res) {
            //     Console.log('onLoadResource', res.url);
            //   },
            // ),

            ///
            child: Center(
              child: progress > 0
                  ? Lottie.asset(
                      Assets.loader,
                      package: Constants.packageName,
                    )
                  : WebViewWidget(
                      controller: _controller,
                      // gestureRecognizers: <Factory<
                      //     OneSequenceGestureRecognizer>>{
                      //   Factory<OneSequenceGestureRecognizer>(
                      //     () => TapGestureRecognizer()
                      //       ..onTap = () {
                      //         debugPrint('Tapppppppeddddd1111!!!!');
                      //       }
                      //       ..onSecondaryTap = () {
                      //         debugPrint('Tapppppppeddddd2222!!!!');
                      //       }
                      //       ..onTertiaryTapDown = (details) {
                      //         debugPrint('Tapppppppeddddd3333!!!!');
                      //       },
                      //   ),
                      // },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initPage() {
    try {
      _controller = WebViewController(onPermissionRequest: (req) async {
        await req.grant();
      })
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        // ..addJavaScriptChannel('document', onMessageReceived: (message) {
        //   debugPrint("DOCUMENT: ${message.message}");
        // })
        ..addJavaScriptChannel('parent', onMessageReceived: (message) {
          debugPrint("MessageFromParent: ${message.message}");
          final res = jsonDecode(message.message);
          if (res['result'] == 'SUCCESS') {
            Navigator.pop(context, true);
          } else {
            Navigator.pop(context, false);
          }
        })
        // ..addJavaScriptChannel('authenticationChallengeCompleteRedirectForm',
        //     onMessageReceived: (message) {
        //   debugPrint(
        //       "authenticationChallengeCompleteRedirectForm: ${message.message}");
        // })

        // ..setUserAgent(
        //     'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.5112.79 Safari/537.36')
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int i) {
              debugPrint("Progress: $i");
              progress = i;
              setState(() {});
            },
            onPageStarted: (String url) {
              debugPrint("Started: $url");
            },
            onPageFinished: (String url) {
              debugPrint("Finished: $url");
              progress = 0;
              setState(() {});
            },
            onUrlChange: (url) {
              debugPrint('UrlChange: ${url.url}');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('WebResourceError: ${error.url}');
              debugPrint('WebResourceError: ${error.description}');
            },
            onNavigationRequest: (NavigationRequest request) {
              debugPrint('Navigation: ${request.url}');
              if (request.url.contains('sandbox.dwayremit.com')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..enableZoom(true)
        ..loadHtmlString('$viewPortHtml ${widget.html}');
//         ..loadHtmlString(
//           '''
//           <html>
//
// <head>
//     <script type="text/javascript">
//       function onLoadSubmit() {
//       if (window.parent) {
//           window.parent.postMessage(JSON.stringify({
//               "result": 'Na me guy'
//           }), '*');
//       };
//       if (document.getElementById('delegate') && document.getElementById('result').value == 'PENDING' && document.getElementById('delegate').value == 'NPCI') {
//           return;
//       }
//       document.authenticationChallengeCompleteRedirectForm.submit();
//     }
//     </script> </head>
//
// <body>
//     <form>
//         <input type="button" value="Click me!" onclick="onLoadSubmit()" />
//     </form> </body>
//
// </html>
//           ''',
//         );
    } catch (e) {
      debugPrint('ERRRROOOORR: $e');
    }
  }
}
