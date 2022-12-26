import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class Nextscreenui extends StatelessWidget {
  final String walletaddress;
  final SessionStatus session;
  final WalletConnect connect;
  const Nextscreenui(
      {Key? key,
      required this.walletaddress,
      required this.session,
      required this.connect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    EthereumWalletConnectProvider provider =
        EthereumWalletConnectProvider(connect);

    void disconnect() async {
      dynamic uri = await connect.killSession();
      print(uri);
      print(await connect.updateSession(session));
    }

    ;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Wallet Address",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: Text(walletaddress)),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: (() => disconnect()),
                child: const Text("Disconnect"))
          ],
        ),
      ),
    );
  }
}
