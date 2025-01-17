import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class GoogleFormPage extends StatefulWidget {
  @override
  _GoogleFormPageState createState() => _GoogleFormPageState();
}

class _GoogleFormPageState extends State<GoogleFormPage> {
  WebViewController? controller; // Changed to nullable
  bool isLoading = true;
  String? formUrl;

  @override
  void initState() {
    super.initState();
    fetchFormUrl();
  }

  // Fetch the latest form URL from the Apps Script
  Future<void> fetchFormUrl() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://docs.google.com/forms/d/1l-PESSi33uaf0xFM1FtL0tQEHLvLWlK8NVcLVJczdO4/edit?usp=drivesdk',
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          formUrl = response.body;
          controller = WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  isLoading = true;
                });
              },
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
            ))
            ..loadRequest(Uri.parse(formUrl!));
        });
      } else {
        throw Exception('Failed to fetch form URL. Status code: ${response.statusCode}');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Form'),
      ),
      body: formUrl == null || controller == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                WebViewWidget(controller: controller!),
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast package
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class GoogleFormPage extends StatefulWidget {
  @override
  _GoogleFormPageState createState() => _GoogleFormPageState();
}

class _GoogleFormPageState extends State<GoogleFormPage> {
  late final WebViewController controller;
  bool isLoading = true;
  String? formUrl;

  @override
  void initState() {
    super.initState();
    fetchFormUrl();
  }

  // Fetch the latest form URL from the Apps Script
  Future<void> fetchFormUrl() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://docs.google.com/forms/d/1l-PESSi33uaf0xFM1FtL0tQEHLvLWlK8NVcLVJczdO4/edit?usp=drivesdk',//'https://script.google.com/macros/s/AKfycbzy0weHV8vmSBk3Qs65PC5CFOqCAH8-npYW13Owcnpleg9cCiFpTLAPqVey7_xYz3Z3/exec',
        ),
      );
      if (response.statusCode == 200) {
        setState(() {
          formUrl = response.body;
        });
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(NavigationDelegate(
            onPageStarted: (url) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (url) {
              setState(() {
                isLoading = false;
              });
            },
          ))
          ..loadRequest(Uri.parse(formUrl!));
      } else {
        throw Exception('Failed to fetch form URL. Status code: ${response.statusCode}');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Form'),
      ),
      body: Stack(
        children: [
          if (formUrl != null)
            WebViewWidget(controller: controller)
          else
            Center(
              child: CircularProgressIndicator(),
            ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
*/