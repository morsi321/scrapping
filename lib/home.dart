import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController _webViewController;
  TextEditingController emailController =
      TextEditingController(text: 'admin@admin.com');
  TextEditingController passwordController =
      TextEditingController(text: 'a123@123');
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  int indexCurrent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.shrink(
              child: WebView(
                initialUrl:
                    'http://hvolcano-001-site2.dtempurl.com/Account/Login?ReturnUrl=%2F',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _webViewController = webViewController;
                },
              ),
            ),
            IndexedStack(
              index: indexCurrent,
              children: [
                Column(
                  children: [
                    Text("Login",
                        style: Theme.of(context)
                            .textTheme
                            .headline4), // Text("Login  ")
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        String scriptLogin =
                            "document.getElementById('Email').value = '${emailController.text}' ; document.getElementById('Password').value = '${passwordController.text}' ; document.querySelector('button.btn.btn-primary').click()";
                        await _webViewController.runJavascript(scriptLogin);
                        setState(() {
                          indexCurrent = 1;
                        });
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Edit Data",
                        style: Theme.of(context)
                            .textTheme
                            .headline4), // Text("Login  ")
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameArController,
                      decoration: const InputDecoration(
                        labelText: 'Name Ar',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameEnController,
                      decoration: const InputDecoration(
                        labelText: 'Name En',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        await _webViewController.runJavascript(scriptChoiceEmp);
                        await Future.delayed(const Duration(seconds: 1));

                        // await _webViewController.runJavascript(scriptDoSearch);

                        await _webViewController.runJavascript(scriptClickEdit);
                        await Future.delayed(const Duration(seconds: 1));

                        String scriptChangeData =
                            "document.querySelector('#EmpNameAr').value='${nameArController.text}'; document.querySelector('#EmpNameEn').value='${nameEnController.text}'; document.querySelector('#Add').click(); document.querySelector('#Delete').click(); document.querySelector('#EmpIsPosetion').click(); document.querySelector('body > div.app-wrapper > div > div > div > div > form > div:nth-child(14) > input').click();  ";

                        await _webViewController
                            .runJavascript(scriptChangeData);
                      },
                      child: const Text('Edit'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _webViewController.runJavascript(scriptLogin);

          await Future.delayed(const Duration(seconds: 1));

          await _webViewController.runJavascript(scriptChoiceEmp);
          await Future.delayed(const Duration(seconds: 1));

          // await _webViewController.runJavascript(scriptDoSearch);

          await _webViewController.runJavascript(scriptClickEdit);
          await Future.delayed(const Duration(seconds: 1));

          await _webViewController.runJavascript(scriptChangeData);
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

String scriptLogin =
    "document.getElementById('Email').value = 'admin@admin.com'; document.getElementById('Password').value = 'a123@123'; document.querySelector('button.btn.btn-primary').click()";
String scriptChoiceEmp =
    "document.querySelector('#submenu-1 > ul > li:nth-child(6) > a > span').click();";
// String scriptDoSearch =
//     "document.querySelector('#dtable_filter > label > input[type=search]').value='وائل'; document.querySelector('#dtable_filter > label > input[type=search]').click();";
String scriptClickEdit =
    "document.querySelector('#dtable > tbody > tr:nth-child(5) > td:nth-child(9) > a.btn.btn-success').click();";
String scriptChangeData =
    "document.querySelector('#EmpNameAr').value='احمد محمد'; document.querySelector('#EmpNameEn').value='ahmed mohamed'; document.querySelector('#Add').click(); document.querySelector('#Delete').click(); document.querySelector('#EmpIsPosetion').click(); document.querySelector('body > div.app-wrapper > div > div > div > div > form > div:nth-child(14) > input').click();  ";
// String scriptChangeData = "document.querySelector('#EmpNameAr').value='احمد محمد'; document.querySelector('#EmpNameEn').value='ahmed mohamed'; document.querySelector('#Add').click(); document.querySelector('#EmpIsPosetion').click(); document.querySelector('#Edit').click(); document.querySelector('#View').click();  document.querySelector('#Delete').click();";
