import 'package:flutter/material.dart';
import 'package:youtube_clone_app/Api.dart';
import 'package:youtube_clone_app/model/Video.dart';

class Inicio extends StatefulWidget {
  String pesquisa;

  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  // Métodos
  _listarVideos(String pesquisa) {
    Future<List<Video>> videos;
    Api api = Api();
    videos = api.pesquisar(pesquisa);

    return videos;
  }

  // Fim Métodos
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    List<Video> videos = snapshot.data;
                    Video video = videos[index];
                    return Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(video.image))),
                        ),
                        ListTile(
                          title: Text(video.title),
                          subtitle: Text(video.channel),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (contex, index) =>
                      Divider(height: 2, color: Colors.grey),
                  itemCount: snapshot.data.length);
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}
