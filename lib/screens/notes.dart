/* height: 250,
      color: Colors.white,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.analytics)),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings_sharp)),
            IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded))
          ],
        ),
      ),
      
      2. height: 200,
                color: Colors.amber,
            
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Modal BottomSheet'),
                      ElevatedButton(
                        child: const Text('Close BottomSheet'),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                
          //showAboutDialog(context: context);
                /*showBottomSheet(
                     elevation: 1,
                   backgroundColor: Colors.black.withOpacity(0.65),
                    context: context,
                    builder: (BuildContext context) {
                      return showSheet();
                    });*/*/
/* decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),*/



/*
 Center(
              child: SizedBox(
                width: 115,
                height: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(),
                    _pickprofileimage(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            _builduserprofile(),
            SizedBox(height: 10),
            // _numbersWidget(),
            biosection(),
           // tarBarHeader(),
            //tarBarSection(),
            
            
            
            
 Future<dynamic> longPageBottomSheet(BuildContext context) {
    return showBarModalBottomSheet(
      context: context,
      expand: true,
      builder: (context) => ListView(
        children: [
          ListTile(
            title: Text('Settings'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Analytics'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecondScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Third Screen'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Third Screen'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Reviews'),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Blocked '),
            trailing: Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox tarBarHeader() {
    return SizedBox(
      height: 60,
      child: AppBar(
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.reviews_outlined),
            ),
            Tab(
              icon: Icon(Icons.report),
            ),
          ],
        ),
      ),
    );
  }

  Widget showSheet() => Container();

  _builduserprofile() => Column(
        children: [
          Text(
            _user['name'],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _user['email'],
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroScreen(),
                    ),
                  );
                },
                child: Text('Business Account'),
              ),
            ],
          )
        ],
      );

  Widget _pickprofileimage() => Positioned(
        right: -1,
        bottom: -7,
        child: SizedBox(
          height: 46,
          width: 46,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: Colors.white,
              ),
            ),
            child: IconButton(
              color: Colors.white,
              iconSize: 16,
              icon: Icon(Icons.edit),
              onPressed: () {
                //leading
              },
            ),
          ),
        ),
      );

  Widget _numbersWidget() => IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "2.0",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Rating",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
            buildDivider(),
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "35",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Likes",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
            buildDivider(),
            MaterialButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "10",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    "Reviews",
                    style: TextStyle(),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildDivider() => SizedBox(
        child: VerticalDivider(),
        height: 24,
      );

  Widget biosection() => Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          "Flutter Intro Slider is a flutter plugin that helps you make a cool intro for your ap",
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      );
  Widget tarBarSection() => Expanded(
        child: TabBarView(
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Bike',
                ),
              ),
            ),
            Container(
              color: Colors.yellow,
              child: Center(
                child: Text(
                  'Car',
                ),
              ),
            ),
          ],
        ),
      );
      
      

  Container profileArea() {
    return Container(
      child: Row(
        children: [
          SizedBox(height: 24),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1641025389903-6d06a65a9c0a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80"),
          ),
          SizedBox(width: 24),
          Column(
            children: [
              Text("Olawale Olawake",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                "holarmidhey@gmail.com",
                style: TextStyle(),
              )
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                  size: 17,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  
  
  
  /* Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(Icons.line_axis),
                color: Colors.blueAccent,
                onPressed: () {},
              ),
            )*/
            
            
             */

/*Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 180,
            width:  160,
            alignment: Alignment.center,
            child: Text("myProducts[index][]",  style:
                  TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
          ),
          Container(
            height: 180,
            width:  160,
            alignment: Alignment.center,
            child: Text("myProducts[index][]",  style:
                  TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold)),
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(15)),
          ),

        
        ],
      ),*/










/*
Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity, //makes it big as my parent allow
            height:
                MediaQuery.of(context).size.height, //makes it big as per screen
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //even space distrubution
              children: <Widget>[
                SizedBox(
                  width: deviceWidth,
                  height: 100,
                  child: Center(
                    child: Text(
                      'Login ',
                      style: TextStyle(color: Colors.blue, fontSize: 30),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Container(
                  width: deviceWidth * 90,
                  height: 100 * .60,
                  decoration: BoxDecoration(
                    color: Color(0XffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: TextField(
                        controller: emailController,
                        onChanged: (text) {
                          if (emailController.text.length >= 2 &&
                              passwordController.text.length >= 2) {
                            inputTextNotNull = true;
                          } else {
                            inputTextNotNull = false;
                          }
                        },
                        obscureText: false,
                        style: TextStyle(fontSize: deviceWidth * .040),
                        decoration: InputDecoration.collapsed(
                            hintText: 'email or phone'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Container(
                  width: deviceWidth * 90,
                  height: 100 * .60,
                  decoration: BoxDecoration(
                    color: Color(0XffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: deviceWidth * .040),
                        decoration:
                            InputDecoration.collapsed(hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                GestureDetector(
                  onLongPressStart: (state) {
                    buttonColor = 0xff78C9FF;
                  },
                  onLongPressEnd: (s) {
                    setState(() {
                      buttonColor = 0xff26A9FF;
                    });
                  },
                  onTap: () {
                    CircularProgressIndicator();
                  },
                  child: Container(
                    width: deviceWidth,
                    height: 100 * .60,
                    decoration: BoxDecoration(
                      color: Color(buttonColor),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth * .040),
                    )),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: deviceWidth * .10,
                      color: Color(0xffA2A2A2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        ' Get help',
                        style: TextStyle(
                            color: Colors.black, //Color(0xff002588),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 1,
                      width: deviceWidth * .10,
                      color: Color(0xffA2A2A2),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: deviceWidth * .35,
                      color: Color(0xffA2A2A2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('OR'),
                    Container(
                      height: 1,
                      width: deviceWidth * .4,
                      color: Color(0xffA2A2A2),
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceWidth * .40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: SizedBox(
                    width: deviceWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'New ? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: deviceWidth * .040,
                                ),
                              ),
                              Text(
                                ' sign up ',
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: deviceWidth * .040,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ), //container padding
        ),
      ),
    );

*/




/*sign up
if (username != null && email != null && password != null) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);

      if (emailValid) {}
    }






    SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity, //makes it big as my parent allow
            height:
                MediaQuery.of(context).size.height, //makes it big as per screen
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, //even space distrubution
              children: <Widget>[
                SizedBox(
                    width: deviceWidth,
                    height: 100,
                    child: Center(
                      child: Text(
                        'Sign Up ',
                        style: TextStyle(color: Colors.blue, fontSize: 30),
                      ),
                    )),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Container(
                  width: deviceWidth * 90,
                  height: 100 * .60,
                  decoration: BoxDecoration(
                    color: Color(0XffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: TextField(
                        controller: usernameController,
                        onChanged: (text) {},
                        obscureText: false,
                        style: TextStyle(fontSize: deviceWidth * .040),
                        decoration: InputDecoration.collapsed(
                          hintText: 'username',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Container(
                  width: deviceWidth * 90,
                  height: 100 * .60,
                  decoration: BoxDecoration(
                    color: Color(0XffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: TextField(
                        controller: emailController,
                        obscureText: false,
                        style: TextStyle(fontSize: deviceWidth * .040),
                        decoration: InputDecoration.collapsed(
                            hintText: 'email or phone'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: deviceWidth * 90,
                  height: 100 * .60,
                  decoration: BoxDecoration(
                    color: Color(0XffE8E8E8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(fontSize: deviceWidth * .040),
                        decoration:
                            InputDecoration.collapsed(hintText: 'Password'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {});
                    _createAccount(usernameController.text,
                        emailController.text, passwordController.text);
                  },
                  child: Container(
                    width: deviceWidth,
                    height: 100 * .60,
                    decoration: BoxDecoration(
                      color: Color(buttonColor),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth * .040,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceWidth * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: deviceWidth * .10,
                      color: Color(0xffA2A2A2),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Forgot Password ?',
                      style: TextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        ' Get help',
                        style: TextStyle(
                            color: Colors.black, //Color(0xff002588),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 1,
                      width: deviceWidth * .10,
                      color: Color(0xffA2A2A2),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 1,
                      width: deviceWidth * .35,
                      color: Color(0xffA2A2A2),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('OR'),
                    Container(
                      height: 1,
                      width: deviceWidth * .4,
                      color: Color(0xffA2A2A2),
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceWidth * .40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: SizedBox(
                    width: deviceWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already have an account ? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: deviceWidth * .040,
                                ),
                              ),
                              Text(
                                ' Login ',
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: deviceWidth * .040,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ), //container padding
        ),
      ),





      Future _createAccount(username, email, password) async {
    debugPrint("pressed");
    final response = await Network.registerUser(username, email, password);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Network.setToken(data[
          'token']); /*print(
          "see what happen when u save a token ${Network.setToken(data['token'])}");*/
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      //display error
    }
  }



   bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
      if (emailValid == true) {
      
    } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email Format incorrect")));
      }









      {
  "user": {
    "name": "ola",
    "email": "gggg@gmail.com",
    "updated_at": "2022-03-20T14:05:45.000000Z",
    "created_at": "2022-03-20T14:05:45.000000Z",
    "id": 1
  },
  "token": "1|QVM34SEBeWeOQu4CruDaOqafsw2dfkLY1bpDbg1x",
  "status": 200
}

if (Platform.isAndroid) {
        platformType = "andriod";
      } else if (Platform.isIOS) {
        platformType = "ios";
      }



ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${response.body}")));




    /*
     var url;
     if (platformType == "andriod") {
      url = Uri.parse('${urlAndriod}auth/register');
    } else {
      url = Uri.parse('${baseURL}auth/register');
      debugPrint(url);
    }*/




/* isLoading
                          ? SizedBox(
                              width: 30,
                              height: 25,
                              child: Image.asset("assets/images/loader2.gif"))
                          : GestureDetector(
                              onTap: () {
                                setState(() {});
                                isLoading = true;
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )*/





 String fileName = file.path.split('/').last;
    final prefs = await SharedPreferences.getInstance();
    final _id = prefs.getInt("id");
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("token")}'
    };

    final request = http.MultipartRequest(
        "PUT", Uri.parse("http://localhost:8000/api/profile/image/${_id}"));
    request.fields["name"] = fileName;
    request.headers.addAll(_headers);

    request.files.add(http.MultipartFile(
        "image", file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split('/').last));
    final res = await request.send();
    final response = await http.Response.fromStream(res);
    final update = jsonDecode(response.body);
    debugPrint("image data response${update}");











Dio dio = Dio();

    /*var response = await dio
        .put("",
            data: _data,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${prefs.getString("token")}'
            }))
        .then((response) => print(response))
        .catchError((error) => print(error));*/

    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    print(file.path);

    var request = dio
        .put(
          "http://localhost:8000/api/profile/image/${_id}",
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${prefs.getString("token")}'
            },
          ),
        )
        .then((response) => print(response))
        .catchError((error) => print(error));






final _token = prefs.getString("token");
    var request = http.MultipartRequest(
        "PUT", Uri.parse("http://localhost:8000/api/profile/image/${id}"));

    request.headers.addAll(
        {'Authorization': 'Bearer $_token', 'Content': 'multipart/form-data"'});
    request.files.add(await http.MultipartFile.fromPath("picture", file.path));
    var pic = await http.MultipartFile.fromPath("image", file.path);

    request.files.add(http.MultipartFile(
        "image", file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split('/').last));
    request.files.add(pic);

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(streamedResponse);
    print("iamge uplaod stat${response.body}");
















 final response = await http
        .put(Uri.parse("http://localhost:8000/api/profile/image/${id}"), body: {
      "image": base64image,
      "name": fileName,
    }, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${prefs.getString("token")}'
    }).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("image uploaded  successfully..."),
            duration: const Duration(seconds: 6),
          ),
        );
      } else {
        print(response.body);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("${error.values.first[0]}"),
        ),
      );
    });








FormData _data = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "id": _id
    });








 showImage(file) async {
    return FutureBuilder(
        future: file,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              null != snapshot.data) {
            return Flexible(child: Image.file(snapshot.data));
          } else if (null != snapshot.error) {
            return Text(
              "error picking image",
              textAlign: TextAlign.center,
            );
          } else {
            return Text(
              "no image selcected",
              textAlign: TextAlign.center,
            );
          }
        });
  }











String uploadurl = "http://localhost:8000/api/profile/image/${id}";
    var response = await http.put(
      Uri.parse(uploadurl),
      body: {'image': base64image, "id": _id, "filename": fileName},
      headers: {'Authorization': 'Bearer ${prefs.getString("token")}'},
    );
    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body); //decode json data
      if (jsondata["error"]) {
        //check error sent from server
        print("returned ${jsondata["msg"]}");
        //if error return from server, show message from server
      } else {
        print("Upload successful");
      }
    } else {
      print("Error during connection to server");
      //there is error during connecting to server,
      //status code might be 404 = url not found
    }





   print(
                                      "here is the long${result.geometry!.location.lng.toString()}");
                                  print(
                                      "here is the lat${result.geometry!.location.lat.toString()}");
                                  /* for (var i in result.addressComponents!) {
                                    // print(": " + i.longName + ": " + i.shortName);
                                    print("Short Name: " +
                                        i.longName +
                                        "Long Name: " +
                                        i.longName);
                                  }*/















Positioned stickyHeader(BuildContext context) {
    return Positioned(
      top: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.red,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            Spacer(),
            Center(child: Text("Create Professional Account")),
            Spacer(),
            isLoading
                ? SizedBox(
                    width: 30,
                    height: 25,
                    child: Image.asset("assets/images/loader2.gif"),
                  )
                : GestureDetector(
                    onTap: () {
                      isLoading = true;

                      setState(() {});
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
          ],
        ),
      ),
    );
  }



 /* print("route: " + value);
                                    print("neighborhood: " + value);
                                    print("locality: " + value);
                                    print("administrative_area_level_2: " +
                                        value);
                                    print("administrative_area_level_1: " +
                                        value);
                                    print("country, political: " + value);
                                    print("postal_code: " + value);*/

                                    //  print(type.toString() + );






     print(base64image);
    final response = await http.put(
        Uri.parse("http://localhost:8000/api/profile/image/${id}"),
        body: jsonEncode(_data),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${prefs.getString("token")}'
        }).then((response) {
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("image uploaded  successfully..."),
            duration: const Duration(seconds: 6),
          ),
        );
      } else {
        print(response.body);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          elevation: 30,
          behavior: SnackBarBehavior.floating,
          content: Text("${error.values.first[0]}"),
        ),
      );
    });
 */







 /*cropped = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      compressQuality: 100,
      maxHeight: 700,
      maxWidth: 700,
      compressFormat: ImageCompressFormat.jpg,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    
    
    
    
    
    
    
    
  chooseImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final imageTemp = File(image.path);
    base64image = base64Encode(imageTemp.readAsBytesSync());
    setState(() {});
    image = imageTemp;
    uploadImage(image);
  }
    
    
    
    
    
    
    final request = await http.patch(
      Uri.parse("http://localhost:8000/api/profile/image/${id}"),
      body: {
        "image": image,
        "filename": filename,
      },
      headers: {
        'Content': 'multipart/form-data',
        'Authorization': 'Bearer ${prefs.getString("token")}'
      },
    );

    final response = jsonDecode(request.body);
    print("iamge uplaod stat${response}");


  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: _FormDatePicker(
                              date: date,
                              onChanged: (value) {
                                setState(() {
                                  date = value;
                                });
                              },
                            ),
                          ),



  getImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    //base64image = base64Encode(imageTemp.readAsBytesSync());
    setState(() {
      image = File(pickedImage!.path); // won't have any error now
    });
    uploadImage(image);
  }

Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ).image;
                                  */



/*
   Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Estimated value',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                Text(
                                  intl.NumberFormat.currency(
                                          symbol: "\$", decimalDigits: 0)
                                      .format(maxValue),
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                Slider(
                                  min: 0,
                                  max: 500,
                                  divisions: 500,
                                  value: maxValue,
                                  onChanged: (value) {
                                    setState(() {
                                      maxValue = value;
                                    });
                                  },
                                ),
                                
                                
                                
        
        
        
        
        
        

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Enable feature',
                                style:
                                    Theme.of(context).textTheme.bodyText1),
                            Switch(
                              value: enableFeature,
                              onChanged: (enabled) {
                                setState(() {
                                  enableFeature = enabled;
                                });
                              },
                            ),
                          ],
                        ),
                      ].expand(
                        (widget) => [
                          widget,
                          const SizedBox(
                            height: 24,
                          )
                          
                          
  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Enable feature',
                                style: Theme.of(context).textTheme.bodyText1),
                            Switch(
                              value: enableFeature,
                              onChanged: (enabled) {
                                setState(() {
                                  enableFeature = enabled;
                                });
                              },
                            ),
                          ],
                        ),                         

  /* Column(
            children: [
              SizedBox(),
              Container(
                width: 500,
                height: MediaQuery.of(context).size.height * .30,
                color: Colors.red,
              ),
              Positioned(
                right: 0,
                bottom: -30,
                child: SizedBox(
                  height: 46,
                  width: 46,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3,
                        color: Colors.white,
                      ),
                    ),
                    child: CircleAvatar(),
                  ),
                ),
              ),
            ],
          ),
        )*/   


 showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    actions: [
                                      SizedBox(
                                        height: 260,
                                        child: CupertinoPicker(
                                          children: [
                                            Text("India"),
                                            Text("Usa"),
                                            Text("Uk"),
                                            Text("Australia"),
                                            Text("Africa"),
                                            Text("New zealand"),
                                            Text("Germany"),
                                            Text("Italy"),
                                            Text("Russia"),
                                            Text("China"),
                                          ],
                                          onSelectedItemChanged: (value) {
                                            print(value);
                                          },
                                          itemExtent: 25,
                                          looping: true,
                                        ),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text("Done"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                });          




var cropped = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(
          ratioX: 1,
          ratioY: 1,
        ),
        compressQuality: 100,
        maxHeight: 700,
        maxWidth: 700,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop Your Images',
          )
        ],
      );
      if (cropped != null) {
        imageTemp = File(cropped.path);
      } else {
        return;
      }
      setState(() {
        image = Image.file(
          imageTemp,
          fit: BoxFit.cover,
        ).image;
        uploadProfessionalAccImages();
      });



if (pics != null && pics.length < 2) {
      imagesList = pics;
      for (var element in pics) {
        imagesList.add(File(element.path));
        print('length: ${imagesList}');
        print('length: ${imagesList.length}');
      }
    } else {
      print(pics!.length);
    }


       ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            elevation: 30,
            behavior: SnackBarBehavior.floating,
            content: Text("Sorry cant pick more than 5 images"),
          ),
        );
        return;  



        SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("click  1");
                      pickBusinessImages();
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: 500,
                        height: MediaQuery.of(context).size.height * .50,
                        color: Colors.grey,
                        child: image == null
                            ? Center(
                                child: Icon(
                                  CupertinoIcons.camera,
                                  color: Colors.white,
                                  size: 75,
                                ),
                              )
                            : Container(child: null)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        "Please select images by clicking icon above",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  /* Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Icon(CupertinoIcons.camera),
                  ),*/
                ],
              ),
            ),
          ),    
    /* final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        imageTemp = File(croppedFile.path);
      } else {
        return;
      }*/


          // var pickedImages = await ImagePicker().pickMultiImage();
    // var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("click  2");
    final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
    print("click  3");
    if (selectedImages!.isNotEmpty) {
      print("click  4");
      imageFileList!.addAll(selectedImages);
    }
    print("click  5");
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});    

    UploadBusinessImage(index) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 20,
    );
    if (pickedImage != null) {
      setState(() {
        image = Image.file(
          imageTemp,
          fit: BoxFit.cover,
        ).image;
        // uploadImage(cropped);
      });
    }
  }  


    GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("hfe");
                      UploadBusinessImage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Icon(
                        CupertinoIcons.camera,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  );



                   showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    builder: (context) => sourceList());


                       InkWell(
              onTap: () {
                
              },


              Expanded(
              child: InkWell(
                child: GridView.builder(
                  itemCount: images.isNotEmpty ? 1 : images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),


               SizedBox(
              width: 115,
              height: 115,
              child: Stack(
                // fit: StackFit.expand,
                // clipBehavior: Clip.none,
                children: [
                  singleImage == null
                      ? Container(
                          padding: EdgeInsets.all(10),
                          width: 500,
                          height: MediaQuery.of(context).size.height * .30,
                          color: Colors.grey,
                          child: Center(
                            child: Icon(
                              CupertinoIcons.camera,
                              color: Colors.white,
                              size: 75,
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.all(10),
                          width: 600,
                          height: MediaQuery.of(context).size.height * .30,
                          child: Image.file(
                            singleImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                  Positioned(
                    top: -60,
                    right: 0,
                    bottom: -7,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 3,
                            color: Colors.white,
                          ),
                        ),
                        child: IconButton(
                          color: Colors.white,
                          iconSize: 16,
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20))),
                                context: context,
                                builder: (context) => sourceList());
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),














   Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            singleImage == null
                ? GestureDetector(
                    onTap: () {
                      chooseSingleImage1;
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 500,
                      height: MediaQuery.of(context).size.height * .30,
                      color: Colors.grey,
                      child: Center(
                        child: Icon(
                          CupertinoIcons.camera,
                          color: Colors.white,
                          size: 75,
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      chooseSingleImage1;
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 600,
                      height: MediaQuery.of(context).size.height * .30,
                      child: Image.file(
                        singleImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            Positioned(
              top: -200,
              right: 0,
              bottom: -7,
              width: 30,
              child: SizedBox(
                height: 46,
                width: 46,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.0),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    iconSize: 20,
                    icon: Icon(FontAwesomeIcons.xmark),
                    onPressed: () {
                      singleImage = null;
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            //  SizedBox(height: 20),
            Divider()
          ],
        ),



           $response = [ 'business_user' => $business_user->id, "has_professional_acc" => $update_professional_status ];
            return response()->json($response);




            final Map<String, dynamic> _user = {
    "name": "Olafemi Arowosegbe",
    "email": "eclat@inteswitch.com",
    "about":
        "Quick check is a soft-search tool that determines if you'll be pre-approved for the thinkmoney Credit Card in 60 seconds, without affecting your Credit Score. This means it's risk-free to check your eligibility, so you can apply with confidence. Top Features: 1.) Up to £1,500 credit limit 2.) No annual fee 3.) One interest rate for all transactions 4.) Manage your account online with our easy-to-use mobile ap",
    "isDarkMode": false,
  };


  // Profile userDetails = Profile.fromJson(jsonDecode(response.body));
      //  final data = json.decode(response.body).cast<Map<String, dynamic>>();
      // List<Profile> details = data.map((e) => Profile.fromJson(e)).toList();
      //<List<Profile>>
      //print(data.name);
      // return data.map<Profile>((json) => Profile.fromJson(json)).toList();

      // print("data returned ${data}");
      // print("data returned ${data["user"]["email"]}");


 Expanded(
              child: InkWell(
                child: GridView.builder(
                  itemCount: images.isNotEmpty ? 1 : images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 600,
                        height: MediaQuery.of(context).size.height * .30,
                        child: images.isEmpty
                            ? null
                            : Image.file(
                                File(images[index].path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),


      
 */

 /*  InkWell(
                  
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: userDetails.image == null
                              ? CircleAvatar(
                                  radius: 30,
                                  child: Icon(Icons.person),
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.grey,
                                )
                              : CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "http://localhost:8000/api/fetch-user-image/${userDetails.image}",
                                  ),
                                ),
                          title: userDetails.name != null
                              ? Text('${userDetails.name}')
                              : Text(''),
                          subtitle: userDetails.bio == null
                              ? Text("")
                              : Text(
                                  "${userDetails.bio}",
                                  //overflow: TextOverflow.ellipsis,
                                ),
                          trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.vertical(
                                                top:
                                                    Radius.circular(20))),
                                    context: context,
                                    builder: (context) =>
                                        bottomSheetList());
                              },
                              icon: Icon(Icons.more_vert_rounded)),
                        ),
                        //  SizedBox(height: 10),
                        userDetails.hasProfessionalAcc == 0
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IntroScreen(),
                                    ),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        'Create Professional Account')),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ManageBusinessAccount(),
                                    ),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        'Manage Professional Account')),
                              )
                      ],
                    ),
                  ),
                ),
                
    OutlinedButton(
                        onPressed: () {},
                        child: Icon(Icons.mail_outline_outlined),
                        style: OutlinedButton.styleFrom(
                            primary: Colors.black,
                            backgroundColor: Colors.black12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            fixedSize: Size(50.0, 60.0)),
                      )

          GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 250.0, crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20.0),
                                  image: DecorationImage(
                                    image: NetworkImage(listImage[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 37.0,
                                      right: 37.0,
                                      top: 185.0,
                                      bottom: 15.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text("1.234k"),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                        ),            

                
                
                
                */

 /*  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 20.0),
                      Column(
                        children: [
                          Text(
                            "29",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Following",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "121.9k",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Followers",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "7.5M",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Like",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: 20.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.0),
                    ],
                  ),
                  
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(340.0, 30.0),
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                
                                ),
                  
                  Future getMutipleImages() async {
    try {
      /*  List? selectedImages = await mutiplePicker.pickMultiImage();
      setState(() {
        if (selectedImages!.isNotEmpty) {
          images.addAll(selectedImages);
        } else {
          print("NO IMAGE SELECTED");
        }
      });*/
    } catch (error) {
      print(error);
    }
  }






    /*  actions: [
          isLoading
              ? SizedBox(
                  width: 30,
                  height: 25,
                  child: Image.asset("assets/images/loader2.gif"),
                )
              : GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        context: context,
                        builder: (context) => sourceList());
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Select",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ),
                ),
        ],*/



       future: fetchPhotos(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return 
            } else {
               return Center(child: CircularProgressIndicator());
            }
          }),

  /*  switch (data) {
          case 1:
          //  singleImage = File(data[]);
            
            break;
          case 2:
          //  secondImage = File(cropped.path);
            
            break;
          case 3:
           // thirdImage = File(cropped.path);
           
            break;
          case 4:
           // fourthImage = File(cropped.path);
           
            break;
          default:
            print("index inserted is${data} but  no match");
        }
      } else {
        return;
      }
     return  print(data);*/






      if($count <= 4 && $count != 0){
            $index = $images[0]["image_order_index"];
           if( $index != $request->index ) {
          
            $success = BusinessAccountImage::updateOrCreate([
                    "business_id" => $request->business_id,
                    "image_name" => $name,
                    "image_order_index" => $request->index,
            ]);
            $file->storeAs('public/business_images/', $name,   ['disk' => 'local'] );
            return response()->json( ["success"  => $success , "taken frnom" => $request->index] );
            exit();
           } else {
           // $user = User::find(auth()->user()->id);
            $success = BusinessAccountImage::where('business_id', '=', $request->business_id)->update(array('image_name' => $name));
           // $success = $images::update(["image_name" => $name ]);
            $file->storeAs('public/business_images/', $name,   ['disk' => 'local'] );
            return response()->json( ["sucessfully_updated"  => $success ] );
            exit();
           }                                                                                                                           /* $success =    BusinessAccountImage::updateOrCreate(
                    [
                    'image_order_index'   => $request->image_order_index,
                    ],
                    [
                        "business_id" => $request->business_id,
                        "image_name" => $name,
                        "image_order_index" => $request->index,
                
                    ],
                );
    
                $file->storeAs('public/business_images/', $name,   ['disk' => 'local'] );
                return response()->json( ["sucessfully_updated"  => $success ] );
                exit();   */                                                                                                                      
           // $file->storeAs('public/business_images/', $name,   ['disk' => 'local'] );
            //$file->move(public_path().'/business_images/',$name);
           // return response()->json( ["success"  => $success ] );
 
        } else {
         //   return response()->json( ["Not authorized"  =>  $count] );
        if($count >= 4){
            return response()->json( ["Not authorized"  =>  "Only 4 pictures allowed"] );
            exit();
         } elseif($images[0]["image_order_index"] != $request->index) {
            $success = BusinessAccountImage::updateOrCreate([
                "business_id" => $request->business_id,
                "image_name" => $name,
                "image_order_index" => $request->index,
            ]);
            $file->storeAs('public/business_images/', $name,   ['disk' => 'local'] );
            return response()->json( ["success"  => $success ] );
            exit();
         } else {
            return response()->json( ["Not authorized"  =>  "no uploads  allowed"] );
         }
          
        }
       
          


          /*   appBar: AppBar(
        leading: null,
        elevation: 1,
        backgroundColor: Theme.of(context).canvasColor,
        actions: [],
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),*/


        /* isLoading
                        ? SizedBox(
                            width: 30,
                            height: 25,
                            child: Image.asset("assets/images/loader2.gif"),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              isLoading = true;
                            },
                            child: Text("Create Professional Account"),
                          ),*/










                           leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 8),
            child: Center(
              child: Text(
                "Close",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),









        FutureBuilder(
        future: fetchBusinessProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return businessPage();
          } else if (snapshot.hasError) {
            return Text("Error");
          } else {
            return Text("Nothing");
          }
        },
      ),
           
           
           /*Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        mainProfileStream = _fetchUser();
                      },
                      child: isLoading
                          ? SizedBox(
                              width: 30,
                              height: 25,
                              child: Image.asset("assets/images/loader2.gif"),
                            )
                          : Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        isLoading = true;
                        updateProfile(
                          fullNameController.text,
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          bioController.text,
                        );
                        setState(() {});
                      },
                      child: isLoading
                          ? SizedBox(
                              width: 30,
                              height: 25,
                              child: Image.asset("assets/images/loader2.gif"),
                            )
                          : Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                    )
                  ],
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
              ),*/



              
           
           
           
           StreamBuilder(
        stream: profileStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return Text("");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("connecting."));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );


  load() async {
    streamController?.add("Loading");
    await Future.delayed(Duration(seconds: 1));
    streamController?.add("Done");
  }

  @override
  void didUpdateWidget(oldWidget) {
    if (true) {
      //something change
      load();
    }
    super.didUpdateWidget(oldWidget);
  }

           */



  /*openFilterDialog() async {
    await FilterListDialog.display<OpeningDay>(
      context,
      listData: openDayList,
      selectedListData: openDayList,
      choiceChipLabel: (openDayList) => openDayList!.weekDay,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (openDayList, query) {
        return openDayList.weekDay!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedOpeningDayList = List.from(list!);
          for (var element in selectedOpeningDayList) {
            print(element.weekDay.toString());
            newselectedOpeningDayList.add(element.weekDay.toString());
          }
        });

        Navigator.pop(context);
      },
    );




     businessImages.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                businessImages.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(_current == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList(),
                          )
                        : Container(child: null),




class ConfirmAuth extends StatefulWidget {
  @override
  _ConfirmAuthState createState() => _ConfirmAuthState();
}

class _ConfirmAuthState extends State<ConfirmAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {});
      isAuth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = LandingPage();

    if (isAuth) {
      child = HomePage();
    }

    if (isAuth == false) {
      child = LoginPage();
    }
    return child;
  }

  /*  */
}

 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    elevation: 30,
                    behavior: SnackBarBehavior.floating,
                    content:
                        Text("Please select opening hours and closing time"),
                  ),
                );


Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                height: 0.2,
                width: MediaQuery.of(context).size.width * .75,
                color: Color(0xffA2A2A2),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => openEditDetails(),
                  );
                  // Respond to button press
                  setState(() {});
                },
                child: Text("edit"),
              ),
              Spacer(),
            ],
          ),
  }*/          

  /*  Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Opening Time',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    openingTime == null
                        ? Icon(
                            Icons.browse_gallery,
                            size: 15,
                          )
                        : Text("${openingTime}")
                  ],
                ),
                TextButton(
                  child: const Text('Select*'),
                  onPressed: () async {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                              actions: [buildOpeningTime()],
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Done")));
                        });
                  },
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Closing Time',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    closingTime == null
                        ? Icon(
                            Icons.browse_gallery,
                            size: 15,
                          )
                        : Text("${closingTime}")
                  ],
                ),
                TextButton(
                  child: const Text('Select'),
                  onPressed: () async {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                              actions: [buildClosingTime()],
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Done")));
                        });
                  },
                )
              ],
            ),
          ),
          
          /*  profile.businessDescription != null
          ? "business_descripition"
          : businessDescription.text: "",
      phoneController.text != null ? "phone" : phoneController.text: "",
      businessCatorgyController.text != null
          ? "business_category"
          : businessCatorgyController.text: "",
      businessSubCatorgyController.text != null
          ? "business_sub_category"
          : businessSubCatorgyController.text: "",
      openingTime != null ? "opening_time" : openingTime.text: "",
      closingTime.text != null
          ? "closing_time"
          : businessSubCatorgyController.text: "",
      "business_id": prefs.getInt("business_id"),*/
          
          
          */