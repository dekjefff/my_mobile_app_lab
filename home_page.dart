import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'category_model.dart';
import 'popular_model.dart';
import 'Todo_list.dart';
import 'contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<TodoListPageState> _todoKey = GlobalKey();
  List<CategoryModel> categories = [];
  List<PopularModel> popularDies = [];

  int _selectedIndex = 0;

  List<Widget> _page = [];

  @override
  void initState() {
    super.initState();
    _getCategories();
    _getPopularModel();

    _page = [_homeView(), TodoListPage(key: _todoKey), ContactView()];
  }

  void _getCategories() {
    categories = CategoryModel.getCategories();
  }

  void _getPopularModel() {
    popularDies = PopularModel.getPopularModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: homeAppBar(),

      body: _page[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), 
            label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Contact',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // สั่งเรียกฟังก์ชันจาก TodoListPage ผ่าน Key
                _todoKey.currentState?.addNewTask();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _homeView() {
    return SingleChildScrollView(
      child: Column(
        children: [_searchBox(), _categoriesSection(), _popularMenu()],
      ),
    );
  }

  Column _popularMenu() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, right: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popular Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          child: ListView.separated(
            shrinkWrap: true, // ให้ listviwe หดตามเนื้อหา
            physics: const NeverScrollableScrollPhysics(), // scoll ตามจอหลัก
            itemCount: popularDies.length,

            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(popularDies[index].iconPath),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(popularDies[index].name),
                          Row(
                            children: [
                              Text(
                                !popularDies[index].isFavorited
                                    ? "Add to Favorites."
                                    : "${popularDies[index].level} | ${popularDies[index].duration} | ${popularDies[index].calorie}",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          popularDies[index].isFavorited =
                              !popularDies[index].isFavorited;
                        });
                      },
                      icon: Icon(
                        popularDies[index].isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: popularDies[index].isFavorited
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Column(children: [Divider()]);
            },
          ),
        ),
      ],
    );
  }

  Column _searchBox() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40, left: 20, right: 20),

          //shadow
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff1D1617).withValues(alpha: .11),
                blurRadius: 40,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              hintText: 'Search Pancake',
              hintStyle: const TextStyle(
                color: Color(0xffdddada),
                fontSize: 14,
              ),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _categoriesSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 200),
          child: Text(
            'Category',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 120,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 20, right: 20),
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                  color: categories[index].boxColor.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      child: SvgPicture.asset(categories[index].iconPath),
                      backgroundColor: Colors.white,
                    ),
                    Text(
                      categories[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 25),
          ),
        ),
      ],
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      title: Text(
        'Menu',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
      ],
    );
  }
}
