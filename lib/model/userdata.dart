import 'account.dart';
import 'friend.dart';
import 'userpost.dart';
import 'usercomment.dart';

class Userdata {
  Account myUserAccount = Account(
    name: 'Rexcel Jay A. Lusica',
    email: 'rexceljaylusica@gmail.com',
    img: 'assets/Profile.jpg',
    followers: 1000000,
    following: 500,
    posts: 350,
  );

  List<Userpost> userList = [
    Userpost(
      id: 'post1',
      userimg: 'assets/Person4.jpg',
      username: 'Mike Johnson',
      time: '5 hrs ago',
      postcontent: 'just finish 1km in 5 mins',
      postimg: 'assets/post1.jpg',
      numcomments: '2',
      numshare: '20',
      isliked: true,
      likes: 24,
      comments: [
        Usercomment(commenter: 'Alice', message: 'Great job!'),
        Usercomment(commenter: 'Bob', message: 'Keep it up!'),
      ],
    ),
    Userpost(
      id: 'post2',
      userimg: 'assets/Person5.jpg',
      username: 'John Doe',
      time: '10 hrs ago',
      postcontent: 'See my GF',
      postimg: 'assets/post2.jpg',
      numcomments: '1',
      numshare: '5',
      isliked: true,
      likes: 15,
      comments: [
        Usercomment(commenter: 'Charlie', message: 'Nice photo!'),
      ],
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/Person1.jpg', name: 'Alice'),
    Friend(img: 'assets/Person2.jpg', name: 'Bob'),
    Friend(img: 'assets/Person3.jpg', name: 'Charlie'),
    Friend(img: 'assets/Person4.jpg', name: 'Diana'),
    Friend(img: 'assets/Person5.jpg', name: 'Ethan'),
    Friend(img: 'assets/Person6.jpg', name: 'Michael'),
  ];

  List<Usercomment> commentLists = [
    Usercomment(commenter: 'Alice', message: 'Great job!'),
    Usercomment(commenter: 'Bob', message: 'Keep it up!'),
    Usercomment(commenter: 'Charlie', message: 'Nice photo!'),
  ];
}
