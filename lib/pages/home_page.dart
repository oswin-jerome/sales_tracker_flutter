import 'package:flutter/material.dart';
import 'package:sales_track/widgets/app_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales tracker - Ajin'),
      ),
      drawer: const MyAppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: [
                  buildTile(context, title: "Today's sale", value: "12"),
                  buildTile(context,
                      title: "Today's amount", value: "150000000"),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Recent sales',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (bc, i) {
                    return const ListTile(
                      title: Text('Dell xps 15',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text('\$1,000,000',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      trailing: Text("1"),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Card buildTile(BuildContext context,
      {String title = "unset", String value = "unset"}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
