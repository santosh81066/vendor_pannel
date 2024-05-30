import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor_pannel/providers/property.dart';

class ManageProperties extends ConsumerStatefulWidget {
  const ManageProperties({super.key});

  @override
  ConsumerState<ManageProperties> createState() => _ManagePropertiesState();
}

class _ManagePropertiesState extends ConsumerState<ManageProperties> with SingleTickerProviderStateMixin {
  // Controller to handle text input for the search field
  final TextEditingController _searchController = TextEditingController();
TabController? _tabController;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
ref.read(propertyProvider.notifier).getProperty();
    _tabController = TabController(length: 4, vsync: this); 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      
      appBar: AppBar(
         
        title: const Text("Manage Properties",style: TextStyle(color:Color(0xFF6414c3),fontSize: 16 ),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 30, color: Color(0xFF6414c3)),  // Your chosen icon
            onPressed: () {
              // Action you want to perform on press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search properties',
                prefixIcon: Icon(Icons.search,color: Color(0xFF6414c3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                
              ),
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Increased radius
                  ),
            child: TabBar(
              
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab, // Limits the indicator to the size of the label
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 1.0, color: Color(0xFF6414c3)),
                  // Blue underline as indicator
              ),
              labelColor: Color(0xFF6414c3),
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Subscribed'),
                Tab(text: 'Deactivated'),
                Tab(text: 'Unsubscribed'),
              ],
            ),
          ),
    
        
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Assuming you have some items count here
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Property $index'), // Example item widget
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
