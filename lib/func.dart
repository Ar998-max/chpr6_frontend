import 'package:http/http.dart' as http;

get_data(String url) async {
  http.Response response = await http.get(
    Uri.parse(url),
    headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          'true', // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "ngrok-skip-browser-warning": "69420"
    },
  );
  return response.body;
}
