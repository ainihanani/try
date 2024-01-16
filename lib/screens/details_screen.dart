import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chewie/chewie.dart';

class Lesson {
  final String title;
  final List<Map<String, String>> shortcuts;
  bool isCompleted;

  Lesson({
    required this.title,
    required this.shortcuts,
    this.isCompleted = false,
  });
}

List<Lesson> lessonList = [
  Lesson(
    title: 'Introduction to Monitor',
    shortcuts: [],
  ),
  Lesson(
    title: 'Introduction to Keyboard',
    shortcuts: [],
  ),
  Lesson(
    title: 'Introduction to Mouse',
    shortcuts: [],
  ),
  Lesson(
    title: 'Introduction to Printer',
    shortcuts: [],
  ),
  Lesson(
    title: 'Introduction to CPU',
    shortcuts: [],
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CourseDetailsScreen(title: 'Introduction to Basic Computer Components'),
    );
  }
}

class CourseDetailsScreen extends StatefulWidget {
  final String title;

  const CourseDetailsScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  int _selectedTag = 0;
  double _totalProgress = 0.0;
  bool isAdmin = false;
  final String adminEmail = 'test@domain.com';
  final String adminPassword = '123456';

  void checkAdminCredentials(String email, String password) {
    if (email == adminEmail && password == adminPassword) {
      setState(() {
        isAdmin = true;
      });
    }
  }

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  void onVideoCompleted(int index) {
    setState(() {
      lessonList[index].isCompleted = true;
      _totalProgress = lessonList.where((lesson) => lesson.isCompleted).length / lessonList.length;
    });
  }

  String? _videoURL;
  VideoPlayerController? _controller;
  String? _downloadURL;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _videoURL = pickedFile.path;
        _controller = VideoPlayerController.file(File(_videoURL!))
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
          });
      }
    });
  }

  Widget _videoPreviewWidget() {
    if (_controller != null) {
      return AspectRatio(
        aspectRatio: _controller!.value.aspectRatio,
        child: VideoPlayer(_controller!),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }

  void _showVideoPlayer({
    required String videoURL,
    required int lessonIndex,
  }) {
    VideoPlayerController videoController = VideoPlayerController.network(videoURL);
    ChewieController chewieController = ChewieController(
      videoPlayerController: videoController,
      autoPlay: true,
      looping: true,
      aspectRatio: 16 / 9,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      showControls: true,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: Chewie(controller: chewieController),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                videoController.pause();
                onVideoCompleted(lessonIndex);
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );

    videoController.initialize().then((_) {
      setState(() {});
      videoController.play();
    });
  }

  void _uploadVideo() async {
    if (!isAdmin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Only admins can upload videos.')),
      );
      return;
    }

    if (_videoURL != null) {
      try {
        String downloadURL = await StoreData().uploadVideo(_videoURL!);
        await StoreData().saveVideoData(downloadURL);

        setState(() {
          _videoURL = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video uploaded successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error uploading video. Please try again.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No video selected.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            LinearProgressIndicator(
                              value: _totalProgress,
                              backgroundColor: Colors.grey,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                _videoURL != null ? _videoPreviewWidget() : const Text('No Video Selected'),
                const SizedBox(height: 15),
                FloatingActionButton(
                  onPressed: _pickVideo,
                  child: const Icon(Icons.video_library),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Basic Components",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => changeTab(0),
                      child: Column(
                        children: [
                          Text(
                            "Play List",
                            style: TextStyle(
                              color: _selectedTag == 0 ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 40,
                            color: _selectedTag == 0 ? Colors.blue : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () => changeTab(1),
                      child: Column(
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                              color: _selectedTag == 1 ? Colors.black : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 40,
                            color: _selectedTag == 1 ? Colors.blue : Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                _selectedTag == 0
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: lessonList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(lessonList[index].title),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: lessonList[index]
                                    .shortcuts
                                    .map((e) => Text('${e['Shortcut']} - ${e['Description']}'))
                                    .toList(),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.play_circle_fill),
                                onPressed: () {
                                  _showVideoPlayer(
                                    videoURL: 'https://firebasestorage.googleapis.com/v0/b/learning-app-9d22e.appspot.com/o/video_2024-01-08_23-52-18.mp4?alt=media&token=eede0769-dec0-429b-8936-12ea7500fb50',
                                    lessonIndex: index,
                                  );

                                },
                              ),

                            );
                          },
                        ),
                      )
                    : const Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            "hardware components:\n\n"
                               "1. Monitor\n"
                "Description:\n"
                "A monitor is an output device that displays visual information generated by a computer. It is an essential part of a computer system, providing a user interface for interacting with applications and content.\n\n"
                "Functions:\n"
                "Display Information: Monitors visually present information such as text, images, videos, and graphical user interfaces.\n"
                "Resolution: Monitors come in various resolutions, affecting the clarity and detail of displayed content.\n"
                "Refresh Rate: Determines how many times the monitor refreshes the image per second, impacting the smoothness of motion.\n"
                "Color Accuracy: Monitors reproduce colors, and accurate color representation is crucial for design and multimedia work.\n"
                "Connectivity: Monitors connect to computers through interfaces like HDMI, DisplayPort, or VGA.\n\n"
                "How to Use:\n"
                "Connect the monitor to the computer using the appropriate cable, power it on, and adjust settings like resolution and brightness through the computer's operating system.\n\n"
                "2. Keyboard\n"
                "Description:\n"
                "A keyboard is an input device that allows users to input alphanumeric characters, numbers, and commands into a computer by pressing keys.\n\n"
                "Functions:\n"
                "Typing: The primary function is to input text by pressing keys with alphanumeric characters.\n"
                "Shortcut Commands: Keyboards often have shortcut keys and combinations for quick access to functions like copy (Ctrl + C) and paste (Ctrl + V).\n"
                "Function Keys: Special keys (F1 to F12) with programmable functions in different applications.\n"
                "Navigation Keys: Arrow keys for navigating within documents or web pages.\n"
                "Special Characters: Access special characters and symbols using Shift or AltGr keys.\n\n"
                "How to Use:\n"
                "Connect the keyboard to the computer through USB or wireless means. Press keys to input characters or execute commands. Learn common shortcuts for increased efficiency.\n\n"
                "3. Mouse\n"
"Description:\n"
"A mouse is an input device that allows users to interact with a computer by moving a cursor on the screen and clicking buttons.\n\n"
"Functions:\n"
"Cursor Movement: The primary function is to move the on-screen cursor by moving the mouse physically on a surface.\n"
"Clicking: Mice typically have left and right buttons for primary and secondary actions respectively, along with a scroll wheel for additional functionality.\n"
"Scrolling: The scroll wheel enables users to navigate through documents or web pages vertically or horizontally.\n"
"Precision: Modern mice come with various sensitivity levels, providing precision in tasks such as graphic design or gaming.\n"
"Gaming: Gaming mice often include additional buttons and customizable features to enhance gameplay.\n\n"
"How to Use:\n"
"Connect the mouse to the computer through USB or wireless connectivity. Move the mouse to control the on-screen cursor, click buttons for actions, and use the scroll wheel for navigation or zooming.\n\n"

"4. Printer\n"
"Description:\n"
"A printer is an output device that produces hard copies of electronic documents or digital images on paper or other physical media.\n\n"
"Functions:\n"
"Document Printing: Print text documents, spreadsheets, presentations, and other textual content.\n"
"Image Printing: Produce high-quality prints of digital images, photographs, and graphics.\n"
"Color Printing: Some printers support color printing, allowing for vibrant and detailed outputs.\n"
"Scanning/Copying: All-in-one printers often include scanning and photocopying functionalities.\n"
"Wireless Printing: Modern printers can connect wirelessly to devices, enabling printing from smartphones, tablets, and computers over a network.\n\n"
"How to Use:\n"
"Connect the printer to the computer via USB, Ethernet, or set it up as a wireless device. Install the necessary printer drivers, load paper and ink or toner cartridges, and send print jobs from your computer or mobile device.\n\n"

"5. Central Processing Unit (CPU)\n"
"Description:\n"
"The Central Processing Unit (CPU) is the core component of a computer system responsible for executing instructions, performing calculations, and managing data flow.\n\n"
"Functions:\n"
"Arithmetic and Logic Operations: The CPU performs basic arithmetic operations (addition, subtraction, multiplication, division) and logical comparisons.\n"
"Data Processing: Manipulates data according to instructions from software applications, ensuring smooth operation and task execution.\n"
"Control Unit: Manages the flow of data and instructions between the CPU and other hardware components, ensuring synchronization and proper operation.\n"
"Cache Memory: Stores frequently accessed data and instructions for quick retrieval, enhancing performance.\n"
"Clock Speed: Represents the CPU's processing speed, measured in gigahertz (GHz), determining how quickly it can execute instructions.\n\n"
"How to Use:\n"
"The CPU is a built-in component of a computer system. Users interact with it indirectly through installed software and applications, which send instructions for execution. Ensure proper cooling and ventilation for optimal performance and longevity.\n\n"

"These descriptions offer insights into the essential hardware components of a computer system, their functions, and usage. Users can delve deeper into each component's specifications and features to harness their full potential in various tasks and applications:",
  
            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class StoreData {
  uploadVideo(String s) {}
  
  saveVideoData(String downloadURL) {}
}

class CustomIconButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final void Function() onTap;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.height = 50,
    this.width = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
