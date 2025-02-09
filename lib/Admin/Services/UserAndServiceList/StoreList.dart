import 'package:flutter/material.dart';
import 'package:laundry_link/User/services/storeService/StoreService.dart';
import '../../../User/components/StoreTile.dart';
import '../../../routes/app_routes.dart';

class StoreList extends StatefulWidget {
  StoreList({super.key});
  @override
  State<StoreList> createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  StoreService storeService = StoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store List"),
      ),
      body: _buildStoreList(),
    );
  }

  Widget _buildStoreList(){
    return StreamBuilder(
        stream: storeService.getStoreList(),
        builder: (context,snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }
          return ListView(
            children : snapshot.data!
                .map<Widget>((storeData) => _bulidStoreListItem(storeData,context))
                .toList(),
          );
        }
    );
  }

  Widget _bulidStoreListItem(Map<String,dynamic> storeData,BuildContext context){
    return StoreTile(
        storeName: storeData['storeName'],
        onTap: (){
          Navigator.pushNamed(
              context,
              AppRoutes.storePage,
              arguments: storeData['storeName']
          );
        }
    );
  }
}
