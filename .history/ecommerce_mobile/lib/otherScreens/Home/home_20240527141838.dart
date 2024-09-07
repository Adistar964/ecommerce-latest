import "dart:convert";

import "package:ecommerce_mobile/configuration/constants.dart";
import "package:ecommerce_mobile/configuration/providerConfig.dart";
import "package:ecommerce_mobile/helper_components/bottomNavbar.dart";
import "package:ecommerce_mobile/helper_components/loading.dart";
import "package:ecommerce_mobile/otherScreens/home/adCarousel.dart";
import "package:ecommerce_mobile/otherScreens/home/categories.dart";
import "package:ecommerce_mobile/otherScreens/home/searchInput.dart";
import "package:flutter/material.dart";
import "package:http/http.dart";
import "package:provider/provider.dart";

// Our homescreen Widget will be a Stateful one, cz we need to first initially fetch data form backend using intiState functions which is only available in stateFulWidget
// and then set it to our corresponding variables in the provider
// Then those variables will be used by other Widgets in our app using provider-package (similar to provider in react)
class HomeScreen extends StatefulWidget {
 //shorthand constructor required
  const HomeScreen ( {super.key} ); 
  
  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool loading = true; // loading state-variable => if true, then loadingScreen widget will be shown

  @override
  void initState() {

    // our functionality
    if(context.mounted){ // first let the app be mounted/set-up

        // start fetching data
        getData();
    }

    // we will not replace initState function from parent-class ,
    // but just extend it, so then after adding our functionality above,
    // we will then run this default initState function
    super.initState(); 
  }

  @override
  Widget build(BuildContext context) {
      if(loading){
        return const LoadingScreen();
      }else{
        return mainBody();
      }
  }

  mainBody() {
      return Scaffold(
        backgroundColor: Colors.grey[170],
        // appbar
        appBar: AppBar( 
          title: Row(
            children: [
              const Expanded(
                child: Center(
                  child: Text("964 SHOP", style: TextStyle(fontWeight: FontWeight.bold) )
                  )
                ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.shopping_cart, size:30),
                  )
              )
            ]
          ) ,
          leading: IconButton(
            onPressed:(){},
           icon: const Icon(Icons.apps, weight: 50, size: 35)
           ),
          
          ),
      
        // app body
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              SearchInput(),
              const SizedBox(height: 20), // leaving some space
              const CategoryCirclesContainer(),
              const Divider(height: 10, color: Colors.black,), // putting a divider
              const SizedBox(height: 17), // leaving some space
              const AdCarousel(), // our component

            ]
          ),
        ),

      // app bottom navbar
      bottomNavigationBar: const BottomNavBar(),
      );
  }

  getData() async {
    // start loading
    setState(() {
      loading = true;
    });
    // anything before variable_name is basically its dtype (u could also give dynamic/final/var)
    Uri url = Uri.parse("$backend_url/getHomePageContent/"); 
    // url should be converted to Uri dtype for it to be passed in http's get method
    Response response = await get( url );
    final data = jsonDecode(response.body);
    context.read<MyProvider>().setHomeData(data);
    // end loading
    setState(() {
      loading = false;
      print("here already");
    });
  }
}

