import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/layout/social_app/cubit/cubit.dart';
import 'package:test_new/layout/social_app/cubit/states.dart';
import 'package:test_new/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: buildDefaultAppBar(context: context,title: 'search'),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextFormField(
                  controller: search,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: 'Search for get users',
                      prefixIcon: Icon(Icons.search_sharp),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.grey))),
                  onChanged: (val) {
                    cubit.searchItem(val);
                  },
                ),
              ),
              Expanded(
                  child: ListView.separated(
                itemCount: cubit.searchList.length == 0
                    ? cubit.users.length
                    : cubit.searchList.length,
                itemBuilder: (context, index) {
                  if (cubit.searchList.isEmpty)
                    return ListTile(
                      leading: Image.network(
                        cubit.users[index].image,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(cubit.users[index].name),
                    );
                  return ListTile(
                    leading: Image.network(
                      cubit.searchList[index]['image'],
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(cubit.searchList[index]['name']),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Column(
                  children: [
                    myDivider(),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ))
            ],
          ),
        );
      },
    );
  }
}
