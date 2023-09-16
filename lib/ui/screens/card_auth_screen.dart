import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initPage();
  }

  void _initPage() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
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
      // ..enableZoom(true)
      ..loadHtmlString(
          '<head> <meta name="viewport" content="width=device-width, initial-scale=0.75, user-scalable=1.0, minimum-scale=0.25, maximum-scale=1.0"></head> <div id="threedsChallengeRedirect" xmlns="http://www.w3.org/1999/html" style="height: 100vh"> <form id ="threedsChallengeRedirectForm" method="POST" action="https://mtf.gateway.mastercard.com/acs/mastercard/v2/prompt" target="challengeFrame"> <input type="hidden" name="creq" value="eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImU4ODdjOWJiLTY3ZWUtNDEzYS1hYTcxLTAxODc0Yjg0ODZlMSJ9" /> </form> <iframe id="challengeFrame" name="challengeFrame" width="100%" height="100%" ></iframe> <script id="authenticate-payer-script"> var e=document.getElementById("threedsChallengeRedirectForm"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>');
    // ..loadRequest(Uri.parse(
    //     'https://webhook.site/5d1c8c84-7e31-4a2c-b852-06f72703fdf7'));
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
            //       child: SingleChildScrollView(
            //         child: HtmlWidget(
            //           // the first parameter (`html`) is required
            //           '''
            //               <form id ="threedsChallengeRedirectForm" method="POST" action="https://mtf.gateway.mastercard.com/acs/mastercard/v2/prompt" target="challengeFrame">
            //     <input type="hidden" name="creq" value="eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImU4ODdjOWJiLTY3ZWUtNDEzYS1hYTcxLTAxODc0Yjg0ODZlMSJ9" />
            // </form>
            // <iframe id="challengeFrame" name="challengeFrame" width="100%" height="100%" ></iframe>
            // <script id="authenticate-payer-script"> var e=document.getElementById("threedsChallengeRedirectForm"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script>
            //           ''',
            //
            //           // all other parameters are optional, a few notable params:
            //
            //           // specify custom styling for an element
            //           // see supported inline styling below
            //           baseUrl: Uri.parse(
            //               'https://mtf.gateway.mastercard.com/acs/mastercard/v2/prompt'),
            //           customStylesBuilder: (element) {
            //             Console.log('CSSS_BUILDER', element.text);
            //             if (element.classes.contains('foo')) {
            //               return {'color': 'red'};
            //             }
            //
            //             return null;
            //           },
            //           factoryBuilder: () => _WidgetFactory(),
            //
            //           // render a custom widget
            //           customWidgetBuilder: (element) {
            //             Console.log('CUSTOM_BUILDER', element.text);
            //             // if (element.attributes['foo'] == 'bar') {
            //             //   return FooBarWidget();
            //             // }
            //
            //             return null;
            //           },
            //
            //           // these callbacks are called when a complicated element is loading
            //           // or failed to render allowing the app to render progress indicator
            //           // and fallback widget
            //           onErrorBuilder: (context, element, error) {
            //             Console.log('ERROR_BUILDER', error.toString());
            //             return Text('$element error: $error');
            //           },
            //           onLoadingBuilder: (context, element, loadingProgress) {
            //             Console.log('LOADING_BUILDER', loadingProgress);
            //             return CircularProgressIndicator();
            //           },
            //           // this callback will be triggered when user taps a link
            //           // onTapUrl: (url) => print('tapped $url'),
            //
            //           // select the render mode for HTML body
            //           // by default, a simple `Column` is rendered
            //           // consider using `ListView` or `SliverList` for better performance
            //           renderMode: RenderMode.column,
            //
            //           // set the default styling for text
            //           textStyle: TextStyle(fontSize: 14),
            //
            //           // turn on `webView` if you need IFRAME support (it's disabled by default)
            //         ),
            //       ),
            child: Center(
              child: progress > 0
                  ? Lottie.asset(
                      Assets.loader,
                      package: Constants.packageName,
                    )
                  : WebViewWidget(
                      controller: _controller,
                      layoutDirection: TextDirection.ltr,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  final hh =
      '<div id="threedsChallengeRedirect" xmlns="http://www.w3.org/1999/html" style="height: 100vh"> <form id ="threedsChallengeRedirectForm" method="POST" action="https://mtf.gateway.mastercard.com/acs/mastercard/v2/prompt" target="challengeFrame"> <input type="hidden" name="creq" value="eyJ0aHJlZURTU2VydmVyVHJhbnNJRCI6ImU4ODdjOWJiLTY3ZWUtNDEzYS1hYTcxLTAxODc0Yjg0ODZlMSJ9" /> </form> <iframe id="challengeFrame" name="challengeFrame" width="100%" height="100%" ></iframe> <script id="authenticate-payer-script"> var e=document.getElementById("threedsChallengeRedirectForm"); if (e) { e.submit(); if (e.parentNode !== null) { e.parentNode.removeChild(e); } } </script> </div>';
}

class _WidgetFactory extends WidgetFactory {
  @override
  final bool webView = true;

  @override
  final bool webViewJs = true;

  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
}
