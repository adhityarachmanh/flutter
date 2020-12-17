/*
module  : AUTH SERVICE
creator : adhityarachmanh
os      : darwin19
created : Thu Dec 17 20:21:01 WIB 2020
product : ARH
version : v1.0
*/

part of '../app.dart';

class AuthService {
    static Future<ResponseAPI> example() async {
        try {
            // GET : var client = await rest.get('URL',headers:{});
            var client = await rest.put('URL',data:{},headers:{});
            var response = ResponseAPI.fromJson(jsonDecode(client.body));
             if (response.s == 1) {
                return ResponseAPI(s: 1, msg: 'Error');
            }
            return response;
        } catch (e) {
            return ResponseAPI(s: 1, msg: 'Server Error');
        }
    }
}
