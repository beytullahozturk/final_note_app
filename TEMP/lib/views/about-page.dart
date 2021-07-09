import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımda'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 70.0,
                backgroundColor: Colors.brown,
                backgroundImage: AssetImage('assets/images/logos.png'),
              ),
              SizedBox(height: 10.0),
              Text(
                'Notlarım App',
                style: TextStyle(
                  fontFamily: 'Nunito-Black',
                  fontSize: 32,
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3301456 kodlu Mobil Programlama dersi kapsamında 203301110 numaralı Beytullah Öztürk tarafından 09 Temmuz 2021 günü yapılmıştır.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
