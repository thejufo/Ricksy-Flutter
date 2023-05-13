import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/api/api_service.dart';
import '/api/data_state.dart';
import '../models/character.dart';
import 'details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarDividerColor: Colors.grey[100]!,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          title: const Text('Ricksy'),
        ),
        body: FutureProvider<DataState<List<Character>>>(
          create: (ctx) {
            final apiService = Provider.of<ApiService>(ctx, listen: false);
            return apiService.getCharacters();
          },
          initialData: DataState(loading: true),
          child: Consumer<DataState<List<Character>>>(
            builder: (ctx, data, _) {
              if (data.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (data.error != null) {
                return Center(child: Text('Error: ${data.error}'));
              } else {
                return _buildCharactersList(data.data!);
              }
            },
          ),
        ),
      ),
    );
  }

  _buildCharactersList(List<Character> characters) {
    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (ctx, index) {
        final Character character = characters[index];
        return OpenContainer(
          transitionDuration: Duration(milliseconds: 500),
          closedElevation: 99,
          transitionType: ContainerTransitionType.fade,
          openBuilder: (ctx, _) {
            return DetailsScreen(character: character);
          },
          closedBuilder: (ctx, openContainer) {
            return Card(
              child: ListTile(
                onTap: () => openContainer(),
                leading: Hero(tag: character.image, child: Image.network(character.image)),
                title: Text(character.name),
                subtitle: Text(character.origin),
              ),
            );
          },
        );
      },
    );
  }
}
