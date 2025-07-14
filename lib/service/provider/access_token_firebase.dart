import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String scopes = 'https://www.googleapis.com/auth/firebase.messaging';

 static Future<String> getAccessToken() async {
    // Load your service account JSON file

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "grocery-app-4ca36",
        "private_key_id": "59bf6845b1b8927ab78e05f23d41abac61a7a619",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCmcWYQcUXCgQch\najlfWg7rkQKTcQmb7b6yMa1FWezWb17OkoNsU2t8qm8HIGVJEXhCp7fOiQbtU47S\nUWDTxrIH4FGbYh1LE9s7toKJndzlPx0bbQOfa2FMvf9m0/j9OimKHF1ewoyxL5k2\nfPY81N3tHPrXkZPeGU9aWpvzrjMkbGO1oS/ZtCwnf2zPCON+JSr5fqQ7T7ULFbdT\nBftThAd6Y4tD9hubeGo9nIt/IgVL+IaBv7XBIKxvbZOL34kyMQj7UnLdXNr1rfox\naxmRVTq93LA5+7GMG+iHhvZAqdaX5dEsWC+d9XUIktKb4+5J4Y4GBokRq+O6IsQV\nmA9cBmmJAgMBAAECggEAJ9y3SL9UKX/s5QITgQRo196YKxcyqbNQDU3L9XTSvc2Y\n+2jIDHjTIJ2R7zdBQrVqI66W3SJgtBSjuzettLKc3zmIWeou4VT9V8j/bPWPmqDZ\nuACNElBtkmtboHUqZ/1WxwLBkukNuH7RlyTo9Us25mufIOM28oWFxXo3aO5CxdlD\nnIrY+yVZsalFJarWjpORy7RzlAYWhcQPCyaZRtFemyEI55xb4r/aN9ZR8lQobs7W\nUcZ+++Hy3hLE4aTqMWM/ueHK9aIsCCqgOeKpj/2LlHnjV0EzKgnT22DlBefIn9bB\nBGjCmlWclcSij4FCHwTsggP9XKzt6trtM6fTJKGJzQKBgQDbnmjP0CKjqayLQrUv\nKm+dTCRMn8FYKzlGfxMnneCCSPMtNhgia8J7LZkb0wcq30+FA3kIMp7U8/eqdLzp\n621J1A/wF49uU6cwjwTB/wj+kPINwYOdmFPme9na3mQZtIF8QxQLnp6EInNceCen\nx33rMX95TGzKsEREpKqdiKv6pQKBgQDCA+jgAcRPLGI51Pj83zEHBB94Xv1fe32/\nQ5sBlUsYl479OPdnsJ9InUmHTaKDP00kE7y0yLcS77zLjuVUz8RJgpzVvlvZmoiT\nz4o4nte1y7mSmCrLKx4figXRyJS6Nyijjlpb4fH6eqCVZEHclBwEi5axW0Q75qM/\nBuUSmXpSFQKBgCt2nDOUc2aEa9tbplPhSBmPOhfX/gGe/ETRXU8X1ZizKz0lWX1m\naiTKj2SMTPzVGP2wBEH1Eq3+YmNfmwuIRia4Szcu0nn5IDth8oUaHgOTV/QU+iE0\nRlZ06FaCcLkNmhqng84Q5DouPzprpR11Q5xKPXoZ/+XVII2dMQ7gP3jpAoGBAILh\nxlCPgJH0nBLtdEaKfnWAN4apdf3avfqwLbpEr5NYcrKqomQFx35h9P9cxRwLMQv8\ncJn4qWAR8GfV7ylmu8DnZsvejfHfCPHF2TXXGife1kJperzySnD2WHSr/oEcwsKL\nPrOrWeUiooAFUVTvaXM7g54DtqU+MrRK/2+rr9P9AoGAfhr7hKCT+Rsiy7iHxMVj\n4WR06xOuFAXCk61jUIoxEdYb5rUZpEixW0h/SVJTU18GVUnEmaJOCIHq6B3jo3h6\nN/3QeF3CwIyVEumXu5JxnwtXxb5Zkzq2UVmbn9/ieG8qKi3+0blG18ZBVfjZ1W0q\nsey9SgYcAOX5oip6h0bfS/8=\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-62l5u@grocery-app-4ca36.iam.gserviceaccount.com",
        "client_id": "100761564182322512867",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-62l5u%40grocery-app-4ca36.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com",
      }),
      [scopes],
    );

    // Return the access token
    return client.credentials.accessToken.data;
  }
}
