import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:tasker/app_icons.dart';
import 'package:tasker/slikker.dart';
import 'package:tasker/info_card.dart';
import 'package:tasker/task_page.dart';
import 'package:tasker/data.dart';
import 'package:tasker/create/page.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return SlikkerScaffold(
      header: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Stack(
          children: [
            SlikkerTextField(
              accent: 240,
              prefixIcon: Icons.search,
              hintText: 'Search everything',
              prefixIconPadding: EdgeInsets.all(18),
              padding: EdgeInsets.fromLTRB(18, 18, 42, 18),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(7),
                child: SlikkerCard(
                  accent: 240,
                  onTap: () => Navigator.pushNamed(context, '/collections'),
                  isFloating: false,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    width: 46,
                    height: 46,
                    child: Center(
                      child: Icon(AppIcons.timeline, color: Color(0xFF3D3D66)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      title: 'Tasker',
      topButton: TopButton(
        icon: Icons.account_circle_rounded,
        title: 'Account',
        action: () => Navigator.pushNamed(context, '/account'),
      ),
      floatingButton: SlikkerCard(
        accent: 240,
        borderRadius: BorderRadius.circular(54),
        padding: EdgeInsets.fromLTRB(14, 15, 16, 15),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(CreatePageType.task, {}),
            )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.add,
              color: Color(0xFF6666FF),
            ),
            Container(width: 7, height: 24),
            Text(
              'Create',
              style: TextStyle(
                color: Color(0xFF6666FF),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        children: [
          _ConnectivityStatus(),
          StreamBuilder(
            stream: data.watch(),
            initialData: null,
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Something went wrong');
              List<Widget> cards = [];
              data.toMap().forEach((key, value) {
                if (key[0] == 'T')
                  cards.add(
                    InfoCard(
                      title: value['title'],
                      description: value['description'],
                      accent: 240,
                      isFloating: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(
                            Map<String, dynamic>.from(value),
                          ),
                        ),
                      ),
                    ),
                  );
              });
              return StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) => cards[index],
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
              );
            },
          )
        ],
      ),
    );
  }
}

class _ConnectivityStatus extends StatefulWidget {
  @override
  __ConnectivityStatusState createState() => __ConnectivityStatusState();
}

class __ConnectivityStatusState extends State<_ConnectivityStatus> {
  String connectivity = '';

  @override
  void initState() {
    super.initState();
    connectivityStatusRefresher = refresh;
    connectivity = connectivityStatus;
  }

  void refresh(String status) => setState(() => connectivity = status);

  @override
  Widget build(BuildContext context) {
    if (connectivity != '')
      return Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: SlikkerCard(
                  accent: 240,
                  isFloating: false,
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      connectivity,
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(height: 30)
        ],
      );
    return Container();
  }
}
