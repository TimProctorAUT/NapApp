import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
 
class DonatePage extends StatefulWidget
{
  @override 
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make A Donatation'),
      ),
      // body: Column(
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Row(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         Html(
      //           data: 
      //             """
      //               <a href="https://github.com">https://github.com</a><br />
      //             """,
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: WebView(initialUrl: "https://www.paypal.com/",),
    );
  }
}