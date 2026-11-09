import 'account.dart';
import 'friend.dart';
import 'userpost.dart';
import 'usercomment.dart';

class Userdata {
  Account myUserAccount = Account(
    name: 'Rexcel Jay Lusica',
    email: 'rexceljay@gmail.com',
    img: 'assets/Profile.jpg',
    followers: 1200,
    following: 480,
    posts: 2,
  );

  List<Userpost> userList = [
    Userpost(
      id: 'post1',
      userimg: 'assets/Person3.jpg',
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
      userimg: 'assets/Person4.jpg',
      username: 'Jane Doe',
      time: '10 hrs ago',
      postcontent: 'Had a great day at the beach!',
      postimg: 'assets/post2.jpg',
      numcomments: '1',
      numshare: '5',
      isliked: true,
      likes: 15,
      comments: [
        Usercomment(commenter: 'Charlie', message: 'Nice photo!'),
      ],
    ),
    Userpost(
      id: 'post3',
      userimg: 'assets/Person5.jpg',
      username: 'Ethan',
      time: '1 day ago',
      postcontent: 'Meet my Gf',
      postimg: 'assets/Post3.jpg',
      numcomments: '3',
      numshare: '10',
      isliked: false,
      likes: 8,
      comments: [
        Usercomment(commenter: 'Alice', message: 'Great job!'),
        Usercomment(commenter: 'Bob', message: 'Keep it up!'),
        Usercomment(commenter: 'Charlie', message: 'Nice pace!'),
      ],
    ),
    Userpost(
      id: 'post4',
      userimg: 'assets/Person5.jpg',
      username: 'Jonathan Smith',
      time: '12 hrs ago',
      postcontent: 'Trump is the best president in the world',
      postimg: 'assets/Post4.jpg',
      numcomments: '3',
      numshare: '10',
      isliked: false,
      likes: 8,
      comments: [
        Usercomment(commenter: 'Alice', message: 'Great job!'),
        Usercomment(commenter: 'Bob', message: 'Keep it up!'),
        Usercomment(commenter: 'Charlie', message: 'Nice pace!'),
      ],
    ),
    Userpost(
      id: 'post5',
      userimg: 'assets/Person6.jpg',
      username: 'Lindy Johnson',
      time: '3 day ago',
      postcontent: 'I want to Break Free!!!',
      postimg: 'assets/Post5.jpg',
      numcomments: '3',
      numshare: '10',
      isliked: false,
      likes: 8,
      comments: [
        Usercomment(commenter: 'Alice', message: 'Great job!'),
        Usercomment(commenter: 'Bob', message: 'Keep it up!'),
        Usercomment(commenter: 'Charlie', message: 'Nice pace!'),
      ],
    ),
    Userpost(
      id: 'post6',
      userimg: 'assets/Person7.jpg',
      username: 'paul walker',
      time: '21 minutes ago',
      postcontent: 'Meet my Friends everyone.',
      postimg: 'assets/Post6.jpg',
      numcomments: '3',
      numshare: '10',
      isliked: false,
      likes: 8,
      comments: [
        Usercomment(commenter: 'Alice', message: 'Great job!'),
        Usercomment(commenter: 'Bob', message: 'Keep it up!'),
        Usercomment(commenter: 'Charlie', message: 'Nice pace!'),
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
