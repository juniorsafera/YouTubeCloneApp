import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:youtube_clone_app/model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyD4vAnR2MZhgq0Ogh_7mhW8IvFhIut6ZeQ";
const ID_CANAL = "UCD5XcAxBOwc7Pd506L0-RAg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  // método para pesquisa de videos
  Future<List<Video>> pesquisar(String pesquisa) async {
    http.Response response = await http.get(URL_BASE +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa");

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);
      List<Video> videos = dadosJson["items"].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      return videos;

    } else {
      print("Erro");
    }
  }
  // fim método para pesquisa de videos

}
