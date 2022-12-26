import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_metamask_connect/homescreen.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MatamaskScreen extends StatefulWidget {
  const MatamaskScreen({Key? key}) : super(key: key);
  static const String routeName = '/matamask-screen';

  @override
  State<MatamaskScreen> createState() => _MatamaskScreenState();
}

class _MatamaskScreenState extends State<MatamaskScreen> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Wallet Connect',
          description: 'An app for connecting to metamask',
          url: 'https://walletconnect.org',
          icons: [
            'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  var _session, _uri, _signature, session;

  loginUsingMetamask(BuildContext context) async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(
            chainId: 5,
            onDisplayUri: (uri) async {
              _uri = uri;
              print(uri);
              await launchUrlString(uri, mode: LaunchMode.externalApplication);
            });
        print("Came");
        print(session.accounts[0]);
        setState(() {
          _session = session;
        });
      } catch (exp) {
        print(exp);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    connector.on(
        'connect',
        (session) => setState(
              () {
                print("Connected");
                _session = _session;
              },
            ));
    connector.on(
        'session_update',
        (payload) => setState(() {
              _session = payload;
              print(_session.accounts[0]);
              print(_session.chainId);
            }));
    connector.on(
        'disconnect',
        (payload) => setState(() {
              print("diconnected");
              _session = null;
            }));
    return Scaffold(
        body: (_session == null)
            ? Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 180,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.purple.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    'MetaMask',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'You can login or create your wallet ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.purpleAccent.shade400,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  ElevatedButton(
                                    onPressed: () =>
                                        loginUsingMetamask(context),
                                    child: const Text(
                                      'Connect Wallet',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ))
                ],
              )
            : Nextscreenui(
                connect: connector,
                session: session,
                walletaddress: session.accounts[0].toString(),
              ));
  }
}
